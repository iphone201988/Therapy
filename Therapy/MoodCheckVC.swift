//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class MoodCheckVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {

            let layout = LeftAlignedCollectionViewFlowLayout()
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 8
            layout.sectionInset = .zero

            collectionView.collectionViewLayout = layout
            
            collectionView.registerCellFromNib(cellID: CounterCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    var categories = ["🙂 Calm", "😟 Anxious", "😔 Sad", "😡 Angry", "😐 Neutral", "🥺 Overwhelmed"]
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
extension MoodCheckVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont(name: "Urbanist-Medium", size: 14.0)
        let category = categories[indexPath.row]
        lbl.text = category
        lbl.sizeToFit()
        return CGSize(width: lbl.frame.width + 20, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CounterCell.identifier, for: indexPath) as! CounterCell
        let category = categories[indexPath.row]
        cell.mainView.cornerRadius = 15
        cell.counter.text = category
        cell.counter.font = UIFont(name: "Urbanist-Medium", size: 14.0)
        cell.mainView.layer.borderColor = UIColor.white.cgColor
        if selectedIndex == indexPath.item {
            cell.mainView.backgroundColor = .white
            cell.mainView.layer.borderWidth = 0
            cell.counter.textColor = UIColor(named: "CB6B4D")
        } else {
            cell.mainView.backgroundColor = .clear
            cell.mainView.layer.borderWidth = 1
            cell.counter.textColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        self.collectionView.reloadData()
    }
}

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y > maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }

        return attributes
    }
}
