//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var name: UrbanistTextField!
    @IBOutlet weak var email: UrbanistTextField!
    @IBOutlet weak var password: UrbanistTextField!
    @IBOutlet weak var hideShowBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateData() -> Bool {
        // MARK: - 1️⃣ Name
        guard !name.text!.isEmptyStr else {
            showError(message: nameMessage)
            return false
        }
        
        guard name.text?.count ?? 0 >= 2 else {
            showError(message: "Name should be at least 2 characters.")
            return false
        }
        
        // MARK: - 2️⃣ Email
        guard !email.text!.isEmptyStr else {
            showError(message: emailMessage)
            return false
        }
        
        guard SharedMethods.shared.isValidEmail(email.text ?? "") else {
            showError(message: "Please enter a valid email address.")
            return false
        }
        
        // MARK: - 4️⃣ Password
        guard !password.text!.isEmptyStr else {
            showError(message: passwordMessage)
            return false
        }
        
        guard password.text?.count ?? 0 >= 8 else {
            showError(message: "Password must be at least 8 characters long.")
            return false
        }
        
        return true
    }
    
    @IBAction func signup(_ sender: UIButton) {
        guard validateData() else { return }
        let params = [
            "email": email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "password": password.text ?? "",
            "name": name.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "deviceType": Constants.deviceType,
            "deviceToken": UserDefaults.standard[.deviceToken] ?? "123"
        ] as [String : Any]
        Task { await signup(params) }
    }
    
}

extension SignUpVC {
    fileprivate func signup(_ params: [String: Any]) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .register,
                                                             model: UserModel.self,
                                                             params: params,
                                                             method: .post,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                if let user = details.data?.user {
                    UserDefaults.standard[.loggedUserDetails] = user
                    let sb = AppStoryboards.main.storyboardInstance
                    let vc = sb.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                    vc.email = email.text ?? ""
                    vc.verifyOTPFor = .register
                    SharedMethods.shared.pushTo(destVC: vc, isAnimated: true)
                }
            }
        }
    }
}


func showError(message:String? = nil) {
    if let message, !message.isEmpty {
        Toast.show(message: message)
    }
}

let firstNameMessage        = NSLocalizedString("First name is required.", comment: "")
let lastNameMessage         = NSLocalizedString("Last name is required.", comment: "")
let nameMessage         = NSLocalizedString("Name is required.", comment: "")
let phoneMessage         = NSLocalizedString("Phone is required.", comment: "")
let emailMessage            = NSLocalizedString("Email is required.", comment: "")
let passwordMessage         = NSLocalizedString("Password is required.", comment: "")
let confirmPasswordMessage  = NSLocalizedString("Confirm password is required.", comment: "")
let mismatchPasswordMessage = NSLocalizedString("Password and Confirm password are not matching.", comment: "")
