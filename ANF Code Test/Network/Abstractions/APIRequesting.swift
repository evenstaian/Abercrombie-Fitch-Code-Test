//
//  APIRequesting.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//
import UIKit

protocol APIRequesting {
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void)
    func getImage(imageString: String, completion: @escaping (UIImage) -> Void)
}
