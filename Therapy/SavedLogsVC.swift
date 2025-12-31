//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class SavedLogsVC: UIViewController {
    
    @IBOutlet weak var tbView: UITableView! {
        didSet {
            tbView.registerCellFromNib(cellID: SavedLogCell.identifier)
            tbView.showsVerticalScrollIndicator = false
            tbView.showsHorizontalScrollIndicator = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Delegates and DataSources
extension SavedLogsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedLogCell.identifier, for: indexPath) as! SavedLogCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "YourJournalVC") as! YourJournalVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
}
