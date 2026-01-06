//
//  PatternsDetectedCell.swift
//  Therapy
//
//  Created by iOS Developer on 06/01/26.
//

import UIKit

class PatternsDetectedCell: UITableViewCell {
      
    @IBOutlet weak var option: UrbanistLabel!
    
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
