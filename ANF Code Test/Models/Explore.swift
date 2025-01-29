//
//  Explore.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation

struct Explore: Codable {
    let title: String
    let backgroundImage: String
    let content: [Content]?
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
}

