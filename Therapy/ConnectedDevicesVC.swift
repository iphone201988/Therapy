//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class ConnectedDevicesVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: ExerciseCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Apple Watch"],
        ["title": "Google Fit"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "SyncVC") as! SyncVC
        SharedMethods.shared.presentVC(destVC: destVC, modalPresentationStyle: .overCurrentContext, isAnimated: true)
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Delegates and DataSources
extension ConnectedDevicesVC: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.title.font = UIFont(name: "Urbanist-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
        
        cell.subTitle1.text = "Last sync: "
        cell.subTitle2.text = "Today, 08:12 AM"
        cell.subTitle3.text = ""
        cell.subTitleImg.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "MindfulBreathingVC") as! MindfulBreathingVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}
