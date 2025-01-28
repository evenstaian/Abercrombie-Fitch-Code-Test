//
//  PromotionCardViewModel.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import UIKit

protocol PromotionCardViewmodeling {
    func getImage(urlString: String, completion: @escaping (UIImage) -> Void)
}

class PromotionCardViewModel: PromotionCardViewmodeling {
    private let service: PromotionCardServicing
    
    init(service: PromotionCardServicing) {
        self.service = service
    }
    
    func getImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        service.getImage(url: urlString) { image in
            completion(image)
        }
    }
}

