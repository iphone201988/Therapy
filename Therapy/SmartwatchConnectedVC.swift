//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class SmartwatchConnectedVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: OnOffCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Sync Heart Rate"],
        ["title": "Sync Sleep Data"],
        ["title": "Sync Steps"],
        ["title": "Sync Stress Level"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func disconnectDevice(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "AddMilestoneVC") as! AddMilestoneVC
        SharedMethods.shared.presentVC(destVC: destVC, isAnimated: true)
    }
}

// MARK: Delegates and DataSources
extension SmartwatchConnectedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OnOffCell.identifier, for: indexPath) as! OnOffCell
        let option = arr[indexPath.row]
        let title = option["title"] ?? ""
        cell.option.text = title
        // for on 999(right) and for off 997 (left)
        cell.toggleView.backgroundColor = UIColor(named: "D9D9D9")
        cell.thumbViewTrailing.priority = UILayoutPriority(997)
        cell.offView.isHidden = false
        cell.onView.isHidden = true
        
        if indexPath.row == 0 {
            cell.toggleView.backgroundColor = UIColor(named: "CB6B4D")
            cell.thumbViewTrailing.priority = UILayoutPriority(999)
            cell.offView.isHidden = true
            cell.onView.isHidden = false
        }
        
        return cell
    }
}
