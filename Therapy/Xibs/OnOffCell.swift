//
//  OnOffCell.swift
//  Therapy
//
//  Created by iOS Developer on 06/01/26.
//

import UIKit

class OnOffCell: UITableViewCell {
      
    @IBOutlet weak var option: UrbanistLabel!
    @IBOutlet weak var toggleView: UIView!
    @IBOutlet weak var thumbView: UIView!
    @IBOutlet weak var onBtn: UIButton!
    @IBOutlet weak var offBtn: UIButton!
    // for on 999(right) and for off 997 (left)
    @IBOutlet weak var thumbViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var onLbl: UrbanistLabel!
    @IBOutlet weak var offLbl: UrbanistLabel!
    @IBOutlet weak var onView: UIView!
    @IBOutlet weak var offView: UIView!
    
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
