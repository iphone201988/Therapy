//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class ReminderVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: ExerciseCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellFromNib(cellID: CounterCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Practice Breathing Exercise"],
        ["title": "Medication - 1 Tablet"],
        ["title": "Therapy Appointment"]
    ]
    
    var categories = ["All", "Exercises", "Medication", "Appointments"]
    var selectedIndex = 0
    
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
    @IBAction func notificationBell(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}

// MARK: Delegates and DataSources
extension ReminderVC: UITableViewDelegate, UITableViewDataSource {
    
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
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "AddReminderVC") as! AddReminderVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}

// MARK: Delegates and DataSources
extension ReminderVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont(name: "Urbanist-Medium", size: 14.0)
        let category = categories[indexPath.row]
        lbl.text = category
        lbl.sizeToFit()
        return CGSize(width: lbl.frame.width + 30, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CounterCell.identifier, for: indexPath) as! CounterCell
        let category = categories[indexPath.row]
        cell.mainView.cornerRadius = 16
        cell.counter.text = category
        cell.counter.font = UIFont(name: "Urbanist-Medium", size: 14.0)
        if selectedIndex == indexPath.item {
            cell.mainView.backgroundColor = UIColor(named: "F1B452")
            cell.mainView.layer.borderWidth = 0
            cell.counter.textColor = .white
        } else {
            cell.mainView.backgroundColor = .white
            cell.mainView.layer.borderWidth = 1
            cell.counter.textColor = UIColor(named: "333333")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        self.collectionView.reloadData()
    }
}
