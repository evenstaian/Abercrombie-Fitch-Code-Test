//
//  ExploreFactory.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import UIKit

enum ExploreFactory {
    static func makeModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Explore", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ANFExploreCardTableViewController") as? ANFExploreCardTableViewController else {
            fatalError("Unable to instantiate ANFExploreCardTableViewController from storyboard")
        }
        
        let API = ApiRequests()
        let service = ExploreService(API: API)
        let viewModel = ExploreViewModel(service: service)
        controller.viewModel = viewModel
        
        return controller
    }
}
