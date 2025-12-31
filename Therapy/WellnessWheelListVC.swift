//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class WellnessWheelListVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: WellnessWheelCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var options = [["title": "Physical", "icon": "image 23", "color": "FFC7EB"],
                   ["title": "Emotional", "icon": "image 24", "color": "FFD961"],
                   ["title": "Financial", "icon": "image 25", "color": "FFF7A0"],
                   ["title": "Social", "icon": "image 26", "color": "FF91A9"],
                   ["title": "Environmental", "icon": "image 27", "color": "00EDFB"],
                   ["title": "Intellectual", "icon": "image 28", "color": "59C0FF"],
                   ["title": "Occupational", "icon": "image 29", "color": "D4C4FF"],
                   ["title": "Spiritual", "icon": "image 30", "color": "DEE6BD"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveMood(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "MoodInsightsVC") as! MoodInsightsVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}

// MARK: Delegates and DataSources
extension WellnessWheelListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WellnessWheelCell.identifier, for: indexPath) as! WellnessWheelCell
        let details = options[indexPath.row]
        let icon = details["icon"]
        let title = details["title"]
        let color = details["color"]
        cell.icon.image = UIImage(named: icon ?? "")
        cell.title.text = title
        cell.mainView.backgroundColor = UIColor(named: color ?? "")
        return cell
    }
}
