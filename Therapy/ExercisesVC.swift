//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class ExercisesVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: SuggestedCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Mindfulness & Meditation", "icon": "image 2"],
        ["title": "Breathing Exercise", "icon": "image 4"],
        ["title": "CBT Activities", "icon": "image 3-1 1"],
        ["title": "Articles & Videos", "icon": "image 3-2"]
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
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bell(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "ExercisesForYouVC") as! ExercisesForYouVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
    
}

// MARK: Delegates and DataSources
extension ExercisesVC: UITableViewDelegate, UITableViewDataSource {
    
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
        let icon = option["icon"] ?? ""
        cell.icon.image = UIImage(named: icon)
        cell.title.text = title
        cell.subTitle.text = ""
        return cell
    }
}
