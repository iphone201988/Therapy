//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: SuggestedCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Personal Info", "icon": ""],
        ["title": "Insights & Reports", "icon": ""],
        ["title": "Change Password", "icon": ""],
        ["title": "Emergency Contacts", "icon": ""],
        ["title": "Devices & Integrations", "icon": ""],
        ["title": "Therapist Support", "icon": ""],
        ["title": "Subscription", "icon": ""],
        ["title": "Logout", "icon": ""]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        topView.layer.cornerRadius = 40
//        topView.layer.maskedCorners = [
//            .layerMinXMaxYCorner, // bottom-left
//            .layerMaxXMaxYCorner  // bottom-right
//        ]
//        topView.clipsToBounds = true
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Delegates and DataSources
// MARK: Delegates and DataSources
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.title.text = title
        cell.subTitle.text = ""
        
        cell.title.font = UIFont(name: "Urbanist-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
        
        cell.iconWidth.constant = 0
        cell.iconTrailing.constant = 0
        cell.mainViewHeight.constant = 74
        
        cell.mainView.layer.borderColor = UIColor(named: "CB6B4D")?.cgColor
        cell.title.textColor = UIColor(named: "333333")
        cell.nextIcon.image = UIImage(named: "Left Icon 1")
        
        if title == "Logout" {
            cell.mainView.layer.borderColor = UIColor(named: "FF5C71")?.cgColor
            cell.title.textColor = UIColor(named: "FF5C71")
            cell.nextIcon.image = UIImage(named: "Left Icon 4")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = arr[indexPath.row]
        let title = option["title"] ?? ""
        if title == "Logout" {
            
        } else if title == "Devices & Integrations" {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "DevicesIntegrationsVC") as! DevicesIntegrationsVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
        } else if title == "Emergency Contacts" {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "EmergencyContactsVC") as! EmergencyContactsVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
        } else if title == "Personal Info" {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "PersonalInfoVC") as! PersonalInfoVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
        } else if title == "Change Password" {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
        } else if title == "Therapist Support" {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "TherapistSupportVC") as! TherapistSupportVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
        }
    }
}
