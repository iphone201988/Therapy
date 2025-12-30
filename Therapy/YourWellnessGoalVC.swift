//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class YourWellnessGoalVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: GoalCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Reduce stress", "icon": "reduceStress"],
        ["title": "Sleep better", "icon": "sleepBetter"],
        ["title": "Manage anxiety", "icon": "manageAnxiety"],
        ["title": "Improve mood", "icon": "improveMood"],
        ["title": "Build mindfulness", "icon": "buildMindfulness"],
        ["title": "Track emotions", "icon": "trackEmotions"],
        ["title": "Support therapy", "icon": "supportTherapy"]
    ]
    
    var selectedOption = ["Sleep better", "Improve mood", "Support therapy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Delegates and DataSources
extension YourWellnessGoalVC: UITableViewDelegate, UITableViewDataSource {
    
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
}
