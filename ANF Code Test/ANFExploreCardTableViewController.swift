//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {

    private var exploreData: [[AnyHashable: Any]]? {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
         let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
         let jsonDictionary = try? JSONSerialization.jsonObject(with: fileContent, options: .mutableContainers) as? [[AnyHashable: Any]] {
            return jsonDictionary
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "exploreContentCell", for: indexPath)
        if let titleLabel = cell.viewWithTag(1) as? UILabel,
           let titleText = exploreData?[indexPath.row]["title"] as? String {
            titleLabel.text = titleText
        }
        
        if let imageView = cell.viewWithTag(2) as? UIImageView,
           let name = exploreData?[indexPath.row]["backgroundImage"] as? String,
           let image = UIImage(named: name) {
            imageView.image = image
        }
        
        return cell
    }
}
