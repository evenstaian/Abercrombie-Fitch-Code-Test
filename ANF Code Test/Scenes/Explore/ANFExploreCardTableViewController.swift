//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    
    var viewModel: ExploreViewmodeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.updateData = { [weak self] exploreData in
            self?.exploreData = exploreData
            self?.tableView.reloadData()
        }
        viewModel?.viewDidLoad()
    }

    private var exploreData: [Explore]?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "exploreContentCell", for: indexPath)
        
        if let data = exploreData?[indexPath.row] {
            if let titleLabel = cell.viewWithTag(1) as? UILabel {
                titleLabel.text = data.title
            }
            
            if let imageView = cell.viewWithTag(2) as? UIImageView,
               let image = UIImage(named: data.backgroundImage) {
                imageView.image = image
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let data = exploreData?[indexPath.row] else { return }
        
        let promotionVC = PromotionCardFactory.makeModule() as! PromotionCardViewController
        promotionVC.configure(with: data)
        navigationController?.pushViewController(promotionVC, animated: true)
    }
}
