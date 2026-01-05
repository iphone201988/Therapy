//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class FindTherapistVC2: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellFromNib(cellID: OptionCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arr = [
        ["title": "Anxiety"],
        ["title": "Sleep"],
        ["title": "Stress"],
        ["title": "Trauma"],
        ["title": "Depression"],
        ["title": "Relationships"],
    ]
    
    var selectedOption = ["Stress"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func findTherapist(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "TherapistMatchingVC") as! TherapistMatchingVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}

// MARK: Delegates and DataSources
extension FindTherapistVC2: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((self.collectionView.frame.width)/2) - 6
        return CGSize(width: width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCell.identifier, for: indexPath) as! OptionCell
        let option = arr[indexPath.row]
        let title = option["title"] ?? ""
        cell.title.text = title
        if selectedOption.contains(title) {
            cell.mainView.backgroundColor = UIColor(named: "ACB884")
            cell.mainView.layer.borderWidth = 0
            cell.selectedUnselectedIcon.image = UIImage(named: "selectedWhite")
            cell.icon.tintColor = .white
            cell.title.textColor = .white
        } else {
            cell.mainView.backgroundColor = .clear
            cell.mainView.layer.borderWidth = 1
            cell.selectedUnselectedIcon.image = UIImage(named: "unselectedGrey")
            cell.icon.tintColor = UIColor(named: "333333")
            cell.title.textColor = UIColor(named: "333333")
        }
        return cell
    }
}
