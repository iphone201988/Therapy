//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class TrackerVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var connectView: UIView!
    @IBOutlet weak var connectedView: UIView!
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: ExerciseCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Anxiety Episodes", "subTitle2": "Today", "subTitle3": "10:20 AM"],
        ["title": "Sleep Quality", "subTitle2": "Yesterday", "subTitle3": "02:00 PM"],
        ["title": "Mood Fluctuations", "subTitle2": "Yesterday", "subTitle3": "05:20 PM"],
        ["title": "Physical Symptoms", "subTitle2": "Today", "subTitle3": "01:55 PM"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topView.layer.cornerRadius = 40
        topView.layer.maskedCorners = [
            .layerMinXMaxYCorner, // bottom-left
            .layerMaxXMaxYCorner  // bottom-right
        ]
        topView.clipsToBounds = true
        
        connectView.isHidden = false
        connectedView.isHidden = true
    }
    
    
    @IBAction func bell(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
    
    @IBAction func connectViewBtn(_ sender: UIButton) {
        connectView.isHidden = true
        connectedView.isHidden = false
    }
    
    @IBAction func addLog(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "AddNewSymptomLogVC") as! AddNewSymptomLogVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}

// MARK: Delegates and DataSources
extension TrackerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseCell.identifier, for: indexPath) as! ExerciseCell
        let option = arr[indexPath.row]
        let title = option["title"] ?? ""
        let subTitle2 = option["subTitle2"] ?? ""
        let subTitle3 = option["subTitle3"] ?? ""
        cell.title.text = title
        cell.subTitle1.text = "Last log: "
        cell.subTitle2.text = subTitle2
        cell.subTitle3.text = subTitle3
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "AnalyticsVC") as! AnalyticsVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}
