//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//


import UIKit

class AISupportVC: UIViewController {
    
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
    
    @IBAction func bell(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
    
    @IBAction func startChat(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "AIAssistantVC") as! AIAssistantVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}
