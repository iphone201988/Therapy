//
//  LeftChatCell.swift
//  Therapy
//
//  Created by iOS Developer on 05/01/26.
//

import UIKit
class LeftChatCell: UITableViewCell {
   

    @IBOutlet weak var title: UrbanistLabel!
    @IBOutlet weak var datetime: UrbanistLabel!
    
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
