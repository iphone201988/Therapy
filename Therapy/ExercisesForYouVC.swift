//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class ExercisesForYouVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: ExerciseCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "5 min Mindful breathing"],
        ["title": "Stress Release meditation"],
        ["title": "Body Scan meditation"],
        ["title": "Anxiety soothing meditation"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Delegates and DataSources
extension ExercisesForYouVC: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.title.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "MindfulBreathingVC") as! MindfulBreathingVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}
