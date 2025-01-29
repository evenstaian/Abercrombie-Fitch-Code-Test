//
//  ExploreService.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation
import UIKit

protocol ExploreServicing {
    var API: APIRequesting { get set }
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void)
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
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
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        self.API.getImage(imageString: url) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
