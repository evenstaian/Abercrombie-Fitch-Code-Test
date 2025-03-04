//
//  ApiRequests.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation
import UIKit
import SystemConfiguration

enum MethodsType: String {
    case GET = "GET"
    case POST = "POST"
}

class ApiRequests: APIRequesting {
    
    private func getConfiguration() -> URLSessionConfiguration {
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Content-Type" : "application/json"]
        config.requestCachePolicy = .returnCacheDataElseLoad
        return config
    }

    private func getSession() -> URLSession{
        return URLSession(configuration: getConfiguration())
    }
    
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void) {
        if let request = buildRequest(url: ApiConstants.baseURL, method: .GET) {
            buildResponse(request: request, completion: completion)
        }
    }
    
    func getImage(imageString: String, completion: @escaping (UIImage) -> Void) {
        let imageStore = ImageStore()
        let imageUrlString = imageString
        if let imageUrl = URL(string: imageUrlString) {
            imageStore.fetch(for: imageUrl) { imageData, _ in
                if let imageData = imageData {
                    completion(imageData)
                }
            }
        }
    }
}

extension ApiRequests {
    private func buildRequest(url: String?, method: MethodsType) -> URLRequest?{
        guard let url = url else {
            return nil
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    private func buildResponse<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        if !NetworkReachability.isConnectedToNetwork() {
            completion(.failure(.noConnection))
        }
        
        let dataTask = getSession().dataTask(with: request) { data, response, error in
            if error == nil {
                
                do {
                    if let data = data {
                        let charactersResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(charactersResponse))
                    }
                } catch {
                    completion(.failure(.notFound))
                }
            }else{
                if !NetworkReachability.isConnectedToNetwork() {
                    completion(.failure(.noConnection))
                } else {
                    completion(.failure(.notFound))
                }
            }
        }
        
        dataTask.resume()
    }
}

class NetworkReachability {
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
}
