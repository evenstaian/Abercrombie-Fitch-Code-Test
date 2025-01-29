//
//  CustomWebviewFactory.swift
//  ANF Code Test
//
//  Created by Evens Taian on 29/01/25.
//

import UIKit

enum CustomWebviewFactory {
    static func makeModule(urlString: String) -> UIViewController {
        let controller = CustomWebviewController(urlString: urlString)
        return controller
    }
}
