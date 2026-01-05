//
//  AIAssistantSectionCell.swift
//  Therapy
//
//  Created by iOS Developer on 05/01/26.
//

import UIKit
class AIAssistantSectionCell: UITableViewCell {
   
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var checkViewTitle: UrbanistTextField!
    @IBOutlet weak var breathingView: UIView!
    @IBOutlet weak var breathingViewTitle: UrbanistLabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var breathingViewValue: UrbanistLabel!
    @IBOutlet weak var startTitleView: UIView!
    
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
