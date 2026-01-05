//
//  OptionCell.swift
//  Therapy
//
//  Created by iOS Developer on 05/01/26.
//

import UIKit
class OptionCell: UICollectionViewCell {
   
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UrbanistLabel!
    @IBOutlet weak var selectedUnselectedIcon: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    @IBOutlet weak var iconLeading: NSLayoutConstraint!
    
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
