//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class JournalDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editJournal(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "JournalDetailsVC") as! JournalDetailsVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}

