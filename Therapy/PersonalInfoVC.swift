//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class PersonalInfoVC: UIViewController {

    @IBOutlet weak var name: UrbanistTextField!
    @IBOutlet weak var email: UrbanistTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            await profile()
        }
        
        populateData()
    }

    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PersonalInfoVC {
    fileprivate func profile() async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .profile,
                                                             model: UserModel.self,
                                                             method: .get,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                if let user = details.data?.user {
                    UserDefaults.standard[.loggedUserDetails] = user
                    populateData()
                }
            }
        }
    }
    
    fileprivate func populateData() {
        let details = UserDefaults.standard[.loggedUserDetails]
        name.text = details?.name ?? ""
        email.text = details?.email ?? ""
    }
}
