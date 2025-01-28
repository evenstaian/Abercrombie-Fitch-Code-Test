//
//  MockApiRequests.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation

class MockApiRequests: APIRequesting {
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void) {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            generateJSONDataCompletion(jsonData: jsonData, completion: completion)
        } else {
            completion(.failure(.unknown))
        }
    }
    
    private func generateJSONDataCompletion<T: Decodable>(jsonData: Data, completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        do {
            let response = try JSONDecoder().decode(T.self, from: jsonData)
            completion(.success(response))
        } catch let error {
            print(error)
            completion(.failure(.unknown))
        }
    }
}
