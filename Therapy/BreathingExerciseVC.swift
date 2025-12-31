//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class BreathingExerciseVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: SuggestedCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var options = [["title": "Calm", "icon": "image 5", "color": "FFC7EB"],
                   ["title": "Focus", "icon": "image 1-1", "color": "FFD961"],
                   ["title": "Sleep", "icon": "image 1-2", "color": "FFF7A0"]]
    
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
extension BreathingExerciseVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedCell.identifier, for: indexPath) as! SuggestedCell
        let details = options[indexPath.row]
        let icon = details["icon"]
        let title = details["title"]
        let _ = details["color"]
        cell.icon.image = UIImage(named: icon ?? "")
        cell.title.text = title
        cell.subTitle.text = ""
        cell.mainView.borderColor = UIColor(named: "ACB884")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "CBTActivitiesVC") as! CBTActivitiesVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}
