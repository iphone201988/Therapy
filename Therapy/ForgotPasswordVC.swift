//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var email: UrbanistTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: UIButton) {
        guard validateData() else { return }
        let params = [
            "email": email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "type": ForgotPasswordFor.forget.rawValue
        ] as [String : Any]
        Task { await forgotPassword(params) }
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
        
        return true
    }
    
}

extension ForgotPasswordVC {
    fileprivate func forgotPassword(_ params: [String: Any]) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .forgotPassword,
                                                             model: UserModel.self,
                                                             params: params,
                                                             method: .post,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success:
                let sb = AppStoryboards.main.storyboardInstance
                let vc = sb.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
                vc.email = email.text ?? ""
                vc.verifyOTPFor = .forgot
                vc.forgotPasswordFor = .forget
                SharedMethods.shared.pushTo(destVC: vc, isAnimated: true)
            }
        }
    }
}
