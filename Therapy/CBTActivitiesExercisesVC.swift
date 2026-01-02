//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class CBTActivitiesExercisesVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellFromNib(cellID: CounterCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: GoalCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var summaryTbView: UITableView! {
        didSet {
            summaryTbView.registerCellFromNib(cellID: SummaryCell.identifier)
            summaryTbView.showsVerticalScrollIndicator = false
            summaryTbView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var saveView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    
    var steps: [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    var patterns = ["Everything always goes wrong.",
                    "This is a disaster, I won’t recover.",
                    "If I’m not perfect, I failed.",
                    "They probably think I’m stupid.",
                    "I feel anxious, so something must be wrong."]
    var selectedPatterns: [String] = ["This is a disaster, I won’t recover."]
    var selectedIndex: Int = 0
    var selectedStep: [Int] = []
    var summaries: [String] = ["Anxiety", "Fear", "Shame"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hideViews()
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "ReflectToLogVC") as! ReflectToLogVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
    
}

// MARK: Delegates and DataSources
extension CBTActivitiesExercisesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 36, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CounterCell.identifier, for: indexPath) as! CounterCell
        let step = steps[indexPath.row]
        cell.counter.text = step
        
        if selectedStep.contains(indexPath.row) || selectedIndex == indexPath.row {
            cell.mainView.borderWidth = 0.0
            
            if selectedStep.contains(indexPath.row) {
                cell.img.image = UIImage(named: "Frame 1995")
            }
            
            if selectedIndex == indexPath.item {
                cell.img.image = UIImage(named: "Frame 1996")
            }
            cell.counter.textColor = .white
        } else {
            cell.mainView.backgroundColor = .white
            cell.mainView.borderWidth = 1.0
            cell.img.image = nil
            cell.counter.textColor = UIColor(named: "333333")
        }
        
        switch selectedIndex {
        case 0: view1.isHidden = false
        case 1: view2.isHidden = false
        case 2: view3.isHidden = false
        case 3: view4.isHidden = false
        case 4: view5.isHidden = false
        case 5: view6.isHidden = false
        case 6: view7.isHidden = false
        case 7:
            view8.isHidden = false
            saveView.isHidden = false
        default: break;
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath.item {
            selectedStep.append(selectedIndex)
            selectedIndex = indexPath.item
            hideViews()
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func hideViews() {
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true
        view8.isHidden = true
        saveView.isHidden = true
    }
}

// MARK: Delegates and DataSources
extension CBTActivitiesExercisesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView == summaryTbView ? summaries.count : patterns.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == summaryTbView {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.identifier, for: indexPath) as! SummaryCell
            let option = summaries[indexPath.row]
            let title = option
            cell.title.text = title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.identifier, for: indexPath) as! GoalCell
            let option = patterns[indexPath.row]
            let title = option
            cell.title.text = title
            cell.title.textAlignment = .left
            cell.title.font = UIFont(name: "Urbanist-Medium", size: 16) ?? .systemFont(ofSize: 16.0, weight: .medium)
            cell.iconWidth.constant = 0.0
            cell.iconLeading.constant = 0.0
            if selectedPatterns.contains(title) {
                cell.mainView.backgroundColor = UIColor(named: "ACB884")
                cell.mainView.layer.borderWidth = 0
                cell.selectedUnselectedIcon.image = UIImage(named: "selectedWhite")
                cell.title.textColor = .white
            } else {
                cell.mainView.backgroundColor = .clear
                cell.mainView.layer.borderWidth = 1
                cell.selectedUnselectedIcon.image = UIImage(named: "unselectedGrey")
                cell.title.textColor = UIColor(named: "333333")
            }
            
            return cell
        }
    }
}
