//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class SyncVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .gray.withAlphaComponent(0.5)
    }
    
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

