//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class DevicesIntegrationsVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: GoalCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Connect Apple Watch", "icon": "reduceStress"],
        ["title": "Connect Samsung Health", "icon": "sleepBetter"],
        ["title": "Connect Google Fit", "icon": "manageAnxiety"],
    ]
    
    var selectedOption = ["Connect Samsung Health"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "ConnectedVC") as! ConnectedVC
        SharedMethods.shared.presentVC(destVC: destVC, modalPresentationStyle: .overCurrentContext, isAnimated: true)
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Delegates and DataSources
extension DevicesIntegrationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.identifier, for: indexPath) as! GoalCell
        let option = arr[indexPath.row]
        let title = option["title"] ?? ""
        let icon = option["icon"] ?? ""
        cell.icon.image = UIImage(named: icon)
        cell.title.text = title
        cell.title.font = UIFont(name: "Urbanist-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)
        
        cell.iconWidth.constant = 0
        cell.iconLeading.constant = 0
        
        if selectedOption.contains(title) {
            cell.mainView.backgroundColor = UIColor(named: "ACB884")
            cell.mainView.layer.borderWidth = 0
            cell.selectedUnselectedIcon.image = UIImage(named: "selectedWhite")
            cell.icon.tintColor = .white
            cell.title.textColor = .white
        } else {
            cell.mainView.backgroundColor = .clear
            cell.mainView.layer.borderWidth = 1
            cell.selectedUnselectedIcon.image = UIImage(named: "unselectedGrey")
            cell.icon.tintColor = UIColor(named: "333333")
            cell.title.textColor = UIColor(named: "333333")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "ConnectedDevicesVC") as! ConnectedDevicesVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}
