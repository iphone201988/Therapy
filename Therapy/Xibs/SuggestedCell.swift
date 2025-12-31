//
//  SuggestedCell.swift
//  Therapy
//
//  Created by iOS Developer on 31/12/25.
//

import UIKit

class SuggestedCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UrbanistLabel!
    @IBOutlet weak var subTitle: UrbanistLabel!
    @IBOutlet weak var mainView: UIView!
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
