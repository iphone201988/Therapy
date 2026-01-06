//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class WellnessWheelIntroListVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: WellnessWheelIntroCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var options = [["title": "Physical", "icon": "image 23", "color": "FFC7EB", "subtitle": "Exercise, nutrition, rest, body care."],
                   ["title": "Emotional", "icon": "image 24", "color": "FFD961", "subtitle": "Understanding and managing feelings."],
                   ["title": "Financial", "icon": "image 25", "color": "FFF7A0", "subtitle": "Money management, security, stress reduction."],
                   ["title": "Social", "icon": "image 26", "color": "FF91A9", "subtitle": "Relationships, connection, community."],
                   ["title": "Environmental", "icon": "image 27", "color": "00EDFB", "subtitle": "Surroundings, nature, impact."],
                   ["title": "Intellectual", "icon": "image 28", "color": "59C0FF", "subtitle": "Learning, creativity, mental challenges."],
                   ["title": "Occupational", "icon": "image 29", "color": "D4C4FF", "subtitle": "Fulfillment in work/daily activities."],
                   ["title": "Spiritual", "icon": "image 30", "color": "DEE6BD", "subtitle": "Purpose, values, beliefs, meaning."]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueTo(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "WheelRatingVC") as! WheelRatingVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}

// MARK: Delegates and DataSources
extension WellnessWheelIntroListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WellnessWheelIntroCell.identifier, for: indexPath) as! WellnessWheelIntroCell
        let details = options[indexPath.row]
        let icon = details["icon"]
        let title = details["title"]
        let subtitle = details["subtitle"]
        let color = details["color"]
        cell.icon.image = UIImage(named: icon ?? "")
        cell.title.text = title
        cell.subTitle.text = subtitle
        cell.mainView.backgroundColor = UIColor(named: color ?? "")
        return cell
    }
}
