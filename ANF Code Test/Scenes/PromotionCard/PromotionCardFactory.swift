//
//  PromotionCardFactory.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import UIKit

enum PromotionCardFactory {
    static func makeModule() -> UIViewController {
        let viewModel = PromotionCardViewModel()
        let controller = PromotionCardViewController(viewModel: viewModel)
        return controller
    }
}
