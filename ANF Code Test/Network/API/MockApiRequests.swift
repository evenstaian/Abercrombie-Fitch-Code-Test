//
//  MockApiRequests.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation

class MockApiRequests: APIRequesting {
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void) {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"){
            generateJSONDataCompletion(jsonString: filePath, completion: completion)
        }
    }
    
    private func generateJSONDataCompletion<T: Decodable>(jsonString: String, completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let response = try JSONDecoder().decode(T.self, from: jsonData)
            completion(.success(response))
        } catch let error {
            print(error)
            completion(.failure(.unknown))
        }
    }
}
