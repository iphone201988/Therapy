//
//  SummaryCell.swift
//  Therapy
//
//  Created by iOS Developer on 02/01/26.
//

import UIKit

class SummaryCell: UITableViewCell {
    
    @IBOutlet weak var title: UrbanistLabel!
    
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
