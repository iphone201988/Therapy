//
//  WheelRatingCell.swift
//  Therapy
//
//  Created by iOS Developer on 06/01/26.
//

import UIKit

class WheelRatingCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UrbanistLabel!
    @IBOutlet weak var subTitle: UrbanistLabel!
    @IBOutlet weak var pickerView: CustomPickerView!
    @IBOutlet weak var pickerParentView: UIView!

    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pickerView.items = ["01", "02", "03", "04", "05", "06", "07", "08"]
        pickerView.selectedRow = 2
        pickerView.onSelectionChanged = { index in }
    }
}
