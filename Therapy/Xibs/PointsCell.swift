//
//  PointsCell.swift
//  Therapy
//
//  Created by iOS Developer on 06/01/26.
//

import UIKit

class PointsCell: UITableViewCell {
      
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    @IBOutlet weak var pointLbl: UrbanistLabel!
    
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
