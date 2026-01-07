//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class CreatePasswordVC: UIViewController {
    
    @IBOutlet weak var newPassword: UrbanistTextField!
    @IBOutlet weak var confirmPassword: UrbanistTextField!
    
    var email = ""
    var resetToken = ""
    var verifyOTPFor: VerifyOTPFor = .forgot
    var forgotPasswordFor: ForgotPasswordFor = .forget
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func create(_ sender: UIButton) {
        guard validateData() else { return }
        let params = [
            "email": email.trimmingCharacters(in: .whitespacesAndNewlines),
            "newPassword": newPassword.text ?? "",
            "resetToken": resetToken
        ] as [String : Any]
        Task { await resetPassword(params) }
    }
    
    func validateData() -> Bool {
        
        
        // MARK: - 4️⃣ Password
        guard !newPassword.text!.isEmptyStr else {
            showError(message: passwordMessage)
            return false
        }
        
        guard newPassword.text?.count ?? 0 >= 8 else {
            showError(message: "Password must be at least 8 characters long.")
            return false
        }
        
        guard !confirmPassword.text!.isEmptyStr else {
            showError(message: confirmPasswordMessage)
            return false
        }
        
        guard confirmPassword.text?.count ?? 0 >= 8 else {
            showError(message: "Password must be at least 8 characters long.")
            return false
        }
        
        guard newPassword.text == confirmPassword.text else {
            showError(message: mismatchPasswordMessage)
            return false
        }
        
        return true
    }
    
}

extension CreatePasswordVC {
    fileprivate func resetPassword(_ params: [String: Any]) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .resetPassword,
                                                             model: UserModel.self,
                                                             params: params,
                                                             method: .post,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                Toast.show(message: details.message ?? "") {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
