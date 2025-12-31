//
//  ViewController.swift
//  Therapy
//
//  Created by iOS Developer on 30/12/25.
//

import UIKit

class YourJournalVC: UIViewController {
    
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
    
    @IBAction func saveJournal(_ sender: UIButton) {
        let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "JournalDetailsVC") as! JournalDetailsVC
        SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
    }
    
}

// MARK: Delegates and DataSources
extension YourJournalVC: UITableViewDelegate, UITableViewDataSource {
    
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
}
