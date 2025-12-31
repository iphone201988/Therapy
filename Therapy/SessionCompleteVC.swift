//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class SessionCompleteVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func create(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func markCompleted(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "BreathingExerciseVC") as! BreathingExerciseVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}

