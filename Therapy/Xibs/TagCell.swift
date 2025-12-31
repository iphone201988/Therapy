//
//  TagCell.swift
//  Therapy
//
//  Created by iOS Developer on 31/12/25.
//

import UIKit

class TagCell: UICollectionViewCell {

    @IBOutlet weak var tagLbl: UrbanistLabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
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
