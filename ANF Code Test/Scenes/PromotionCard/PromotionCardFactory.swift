//
//  PromotionCardFactory.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import UIKit

enum PromotionCardFactory {
    static func makeModule() -> UIViewController {
        let API = ApiRequests()
        let service = PromotionCardService(API: API)
        let viewModel = PromotionCardViewModel(service: service)
        let controller = PromotionCardViewController(viewModel: viewModel)
        return controller
    }
}
