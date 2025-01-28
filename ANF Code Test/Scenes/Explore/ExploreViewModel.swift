//
//  ExploreViewModel.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation

protocol ExploreViewmodeling {
    var updateData: (([Explore]) -> Void)? { get set }
    func viewDidLoad()
}

class ExploreViewModel: ExploreViewmodeling {
    var updateData: (([Explore]) -> Void)?
    
    func viewDidLoad() {
        getExploreData()
    }
    
    func getExploreData() {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
           let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            let exploreData: [Explore]? = try? JSONDecoder().decode([Explore].self, from: fileContent)
            
            if let exploreData = exploreData {
                self.updateData?(exploreData)
            }
        }
    }
}
