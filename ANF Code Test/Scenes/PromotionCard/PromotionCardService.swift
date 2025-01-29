//
//  PromotionCardService.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation
import UIKit

protocol PromotionCardServicing {
    var API: APIRequesting { get set }
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class PromotionCardService: PromotionCardServicing {
    var API: APIRequesting
    
    init(API: APIRequesting){
        self.API = API
    }
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        self.API.getImage(imageString: url) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

