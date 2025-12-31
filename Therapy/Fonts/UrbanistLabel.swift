import UIKit

@IBDesignable
class UrbanistLabel: UILabel {

    @IBInspectable var urbanistStyle: String = "Regular" {
        didSet {
            updateFont()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateFont()
    }

    private func updateFont() {
        let fontName = "Urbanist-\(urbanistStyle)"
        if let customFont = UIFont(name: fontName, size: self.font.pointSize) {
            self.font = customFont
        } else {
            LogHandler.debugLog("⚠️ Font '\(fontName)' not found. Make sure it is added to Info.plist and the app bundle.")
        }
    }
}

@IBDesignable
class UrbanistTextField : UITextField {

    @IBInspectable var urbanistStyle: String = "Regular" {
        didSet {
            updateFont()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateFont()
    }

    private func updateFont() {
        let fontName = "Urbanist-\(urbanistStyle)"
        if let customFont = UIFont(name: fontName, size: self.font?.pointSize ?? 16.0) {
            self.font = customFont
        } else {
            LogHandler.debugLog("⚠️ Font '\(fontName)' not found. Make sure it is added to Info.plist and the app bundle.")
        }
    }
}

@IBDesignable
class UrbanistTextView : UITextView {

    @IBInspectable var urbanistStyle: String = "Regular" {
        didSet {
            updateFont()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateFont()
    }

    private func updateFont() {
        let fontName = "Urbanist-\(urbanistStyle)"
        if let customFont = UIFont(name: fontName, size: self.font?.pointSize ?? 16.0) {
            self.font = customFont
        } else {
            LogHandler.debugLog("⚠️ Font '\(fontName)' not found. Make sure it is added to Info.plist and the app bundle.")
        }
    }
}
