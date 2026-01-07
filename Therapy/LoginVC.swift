//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var email: UrbanistTextField!
    @IBOutlet weak var password: UrbanistTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func register(_ sender: UIButton) {
        let sb = AppStoryboards.main.storyboardInstance
        let vc = sb.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        SharedMethods.shared.pushTo(destVC: vc, isAnimated: true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard validateData() else { return }
        let params = [
            "email": email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "password": password.text ?? "",
            "deviceType": Constants.deviceType,
            "deviceToken": UserDefaults.standard[.deviceToken] ?? "123"
        ] as [String : Any]
        Task { await login(params) }
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        let sb = AppStoryboards.main.storyboardInstance
        let vc = sb.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        SharedMethods.shared.pushTo(destVC: vc, isAnimated: true)
    }
    
    func validateData() -> Bool {
        
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
    
}

extension LoginVC {
    fileprivate func login(_ params: [String: Any]) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .login,
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
                }
                
                if let token = details.data?.tokens?.accessToken {
                    UserDefaults.standard[.accessToken] = token
                    SharedMethods.shared.navigateToTabbarsVC()
                } else {
                    let sb = AppStoryboards.main.storyboardInstance
                    let vc = sb.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                    vc.email = email.text ?? ""
                    SharedMethods.shared.pushTo(destVC: vc, isAnimated: true)
                }
            }
        }
    }
}
