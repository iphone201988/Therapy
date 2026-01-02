//
//  CounterCell.swift
//  Therapy
//
//  Created by iOS Developer on 02/01/26.
//

import UIKit

class CounterCell: UICollectionViewCell {

    @IBOutlet weak var counter: UrbanistLabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewWidth: NSLayoutConstraint!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
