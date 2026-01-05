//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: SuggestedCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellFromNib(cellID: QuickCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    var suggestedForYou = [["icon": "image 1", "title": "5-min Morning:", "subTitle": "Meditation"],
                           ["icon": "image 3", "title": "Breathing Exercise:", "subTitle": "Calm Mind"],
                           ["icon": "image 3-1", "title": "Journaling Prompt: ", "subTitle": "What do I need today?"]]
    
    var quickActions = [["icon": "Group 23", "title": "Mood Log"],
                        ["icon": "Group 23-1", "title": "Journal Log"]]
    
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
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "MoodSelectorVC") as! MoodSelectorVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
    
    @IBAction func profile(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
    
}

// MARK: Delegates and DataSources
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        suggestedForYou.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedCell.identifier, for: indexPath) as! SuggestedCell
        let details = suggestedForYou[indexPath.row]
        let icon = details["icon"]
        let title = details["title"]
        let subTitle = details["subTitle"]
        cell.icon.image = UIImage(named: icon ?? "")
        cell.title.text = title
        cell.subTitle.text = subTitle
        return cell
    }
}

// MARK: Delegates and DataSources
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quickActions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuickCell.identifier, for: indexPath) as! QuickCell
        let details = quickActions[indexPath.row]
        let icon = details["icon"]
        let title = details["title"]
        cell.icon.image = UIImage(named: icon ?? "")
        cell.title.text = title
        if indexPath.item == 0 {
            cell.mainView.borderColor = UIColor(named: "CB6B4D")
            cell.title.textColor = UIColor(named: "CB6B4D")
        } else {
            cell.mainView.borderColor = UIColor(named: "ACB884")
            cell.title.textColor = UIColor(named: "ACB884")
        }
        return cell
    }
}
