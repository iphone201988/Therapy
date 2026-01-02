//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class NotificationsVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: GoalCell.identifier)
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
        "7:00 PM — Time for your breathing exercise",
        "Take 1 tablet now",
        "You missed yesterday’s exercise",
        "Your therapy session starts in 2 hours"]
    
    var categories = ["All", "Exercises", "Medication", "Appointments"]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Delegates and DataSources
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.identifier, for: indexPath) as! GoalCell
        let option = arr[indexPath.row]
        let title = option
        cell.title.text = title
        cell.iconWidth.constant = 0.0
        cell.iconLeading.constant = 0.0
        cell.icon2Width.constant = 0.0
        cell.icon2Leading.constant = 0.0
        cell.mainView.borderColor = UIColor(named: "333333")
        cell.title.font = UIFont(name: "Urbanist-Medium", size: 14) ?? .systemFont(ofSize: 14.0, weight: .medium)
        if indexPath.item == 0 {
            cell.icon2Width.constant = 12.0
            cell.icon2Leading.constant = 8.0
            cell.mainView.borderColor = UIColor(named: "F1B452")
            cell.selectedUnselectedIcon.backgroundColor = UIColor(named: "F1B452")
            cell.selectedUnselectedIcon.cornerRadius = 6
        }
        return cell
    }
}

// MARK: Delegates and DataSources
extension NotificationsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
