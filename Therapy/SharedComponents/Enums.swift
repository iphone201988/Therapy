import UIKit

enum AppStoryboards: String {
    case main = "Main"
    case menus = "Menus"
    
    var storyboardInstance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func controller<T: UIViewController>(_ type: T.Type) -> T? {
        let identifier = String(describing: type)
        return storyboardInstance.instantiateViewController(withIdentifier: identifier) as? T
    }
}

enum VerifyOTPFor: String {
    case forgot
    case register
}

enum ForgotPasswordFor: Int {
    case register = 1
    case resendRegister = 2
    case forget = 3
    case resendForget = 4
}
