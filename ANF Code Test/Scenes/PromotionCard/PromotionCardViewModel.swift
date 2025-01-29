//
//  PromotionCardViewModel.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import UIKit

protocol PromotionCardViewmodeling {
    func configure(with explore: Explore)
    func getImage(urlString: String, completion: @escaping (UIImage) -> Void)
    func getContent(at index: Int) -> Content?
}

class PromotionCardViewModel: PromotionCardViewmodeling {
    private let service: PromotionCardServicing
    private var explore: Explore?
    
    init(service: PromotionCardServicing) {
        self.service = service
    }
    
    func getImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        service.getImage(url: urlString) { image in
            completion(image)
        }
    }
    
    func getContent(at index: Int) -> Content? {
        guard let content = explore?.content,
              index >= 0 && index < content.count else {
            return nil
        }
        return content[index]
    }
    
    func configure(with explore: Explore) {
        self.explore = explore
    }
}

