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
   // @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var pickerView: CustomPickerView!
    @IBOutlet weak var pickerParentView: UIView!
    
   // private var customPicker: CustomPickerView!
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // setupPicker()
        
        pickerView.items = ["01", "02", "03", "04", "05", "06", "07", "08"]
        pickerView.selectedRow = 2

        pickerView.onSelectionChanged = { index in
            print("Selected:", index)
        }
    }
    
//    private func setupPicker() {
//        customPicker = CustomPickerView(frame: CGRect(x: 0,
//                                                      y: 0,
//                                                      width: pickerView.bounds.width,
//                                                      height: pickerView.bounds.height))
//        customPicker.items = ["01", "02", "03", "04", "05", "06", "07", "08"]
//        customPicker.selectedRow = 2 // Select "07"
//        
//        customPicker.onSelectionChanged = { _ in }
//        
//        pickerView.addSubview(customPicker)
//    }
}
