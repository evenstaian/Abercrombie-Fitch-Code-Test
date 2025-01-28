//
//  ExploreService.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation

protocol ExploreServicing {
    var API: APIRequesting { get set }
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void)
}

class ExploreService: ExploreServicing {
    var API: APIRequesting
    
    init(API: APIRequesting){
        self.API = API
    }
    
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void) {
        self.API.getExploreData() { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
