//
//  APIRequesting.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

protocol APIRequesting {
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void)
}
