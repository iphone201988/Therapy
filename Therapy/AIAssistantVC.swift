//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class AIAssistantVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: RightChatCell.identifier)
            tbView.registerCellFromNib(cellID: LeftChatCell.identifier)
            tbView.registerCellFromNib(cellID: AIAssistantSectionCell.identifier)
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
    
    var categories = ["Breathing Exercise", "Grounding", "Reframe Thought", "Learn About Anxiety"]
    var msgs: [String] = ["I’m feeling very anxious right now.",
                          "I’m here with you. Would you like to share more or do a quick mood check?",
                          "Thank you for telling me. Since you're feeling anxious at level 7, I recommend a grounding exercise to help calm your mind.",
                          "3-min Breathing",
                          "Write Journal Prompt",
                          "Sleep Prep Audio",
                          "Do Mood Check",
                          "Read Guide"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func send(_ sender: UIButton) { }
    
}

// MARK: Delegates and DataSources
extension AIAssistantVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        msgs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = msgs[indexPath.row]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RightChatCell.identifier, for: indexPath) as! RightChatCell
            cell.title.text = msg
            return cell
        } else if (indexPath.row == 1 || indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeftChatCell.identifier, for: indexPath) as! LeftChatCell
            cell.title.text = msg
            return cell
        } else if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
            let cell = tableView.dequeueReusableCell(withIdentifier: AIAssistantSectionCell.identifier, for: indexPath) as! AIAssistantSectionCell
            cell.checkView.isHidden = true
            cell.breathingView.isHidden = false
            cell.breathingViewTitle.text = msg
            if indexPath.row == 4 {
                cell.startView.isHidden = false
                cell.breathingViewValue.isHidden = false
                cell.breathingViewTitle.isHidden = true
                cell.startTitleView.isHidden = true
            } else {
                cell.startView.isHidden = true
                cell.breathingViewValue.isHidden = true
                cell.breathingViewTitle.isHidden = false
                cell.startTitleView.isHidden = false
            }
            return cell
        }  else if indexPath.row == 6 || indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AIAssistantSectionCell.identifier, for: indexPath) as! AIAssistantSectionCell
            cell.checkView.isHidden = false
            cell.breathingView.isHidden = true
            cell.checkViewTitle.text = msg
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let msg = msgs[indexPath.row]
        if msg == "Do Mood Check" {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "MoodCheckVC") as! MoodCheckVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
        }
        
        if msg == "Read Guide" {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "PsychoeducationVC") as! PsychoeducationVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
        }
    }
}

// MARK: Delegates and DataSources
extension AIAssistantVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        return CGSize(width: lbl.frame.width + 20, height: 26)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CounterCell.identifier, for: indexPath) as! CounterCell
        let category = categories[indexPath.row]
        cell.mainView.cornerRadius = 13
        cell.counter.text = category
        cell.counter.font = UIFont(name: "Urbanist-Medium", size: 14.0)
        return cell
    }
}
