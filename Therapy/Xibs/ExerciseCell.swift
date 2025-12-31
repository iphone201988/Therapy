//
//  ExerciseCell.swift
//  Therapy
//
//  Created by iOS Developer on 31/12/25.
//

import UIKit

class ExerciseCell: UITableViewCell {
    
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
