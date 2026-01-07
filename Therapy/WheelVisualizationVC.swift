//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit


//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class WheelVisualizationVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: SuggestedCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Strong Areas", "subTitle": "Social, Emotional"],
        ["title": "Areas needing support", "subTitle": "Physical"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        let rootVC = storyboard.instantiateViewController(withIdentifier: "TabbarsVC") as! TabbarsVC
       SharedMethods.shared.navigateToRootVC(rootVC: rootVC)
    }
    
}

// MARK: Delegates and DataSources
extension WheelVisualizationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedCell.identifier, for: indexPath) as! SuggestedCell
        let option = arr[indexPath.row]
        let title = option["title"] ?? ""
        let subTitle = option["subTitle"] ?? ""
        cell.title.text = title
        cell.subTitle.text = subTitle
        
        cell.title.font = UIFont(name: "Urbanist-Bold", size: 24) ?? .systemFont(ofSize: 24, weight: .bold)
        cell.subTitle.font = UIFont(name: "Urbanist-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
        
        cell.iconWidth.constant = 0
        cell.iconTrailing.constant = 0
        cell.nextIcon.isHidden = true
        cell.mainViewHeight.constant = 90
        
        cell.mainView.layer.borderColor = UIColor(named: "CB6B4D")?.cgColor
        cell.title.textColor = UIColor(named: "333333")
        cell.subTitle.textColor = UIColor(named: "CB6B4D")

        return cell
    }
}
