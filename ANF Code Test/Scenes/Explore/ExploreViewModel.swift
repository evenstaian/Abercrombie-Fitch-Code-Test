//
//  ExploreViewModel.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation
import UIKit

protocol ExploreViewmodeling {
    var updateData: (([Explore]) -> Void)? { get set }
    var onRequestError: ((String) -> Void)? { get set }
    func viewDidLoad()
    func getImage(urlString: String, completion: @escaping (UIImage) -> Void)
}

class ExploreViewModel: ExploreViewmodeling {
    
    private let service: ExploreServicing
    
    var exploreData: [Explore] = []
    var updateData: (([Explore]) -> Void)?
    var onRequestError: ((String) -> Void)?
    
    init(service: ExploreServicing){
        self.service = service
    }
    
    func viewDidLoad() {
        getExploreData()
    }
    
    func getExploreData() {
        service.getExploreData { [weak self] result in
            switch result {
            case .success(let response):
                self?.exploreData.append(contentsOf: response)
                if let exploreData = self?.exploreData {
                    self?.updateData?(exploreData)
                }
            case .failure(let error):
                switch error {
                case .noConnection:
                    self?.onRequestError?("No internet connection. Please check your network and try again.")
                case .notFound:
                    self?.onRequestError?("Explore data not found. Please try again later.")
                default:
                    self?.onRequestError?("An unexpected error occurred. Please try again later.")
                }
                print("Error fetching exploreData: \(error)")
            }
        }
    }
    
    func getImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        service.getImage(url: urlString) { image in
            completion(image)
        }
    }
}
