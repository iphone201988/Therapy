import UIKit

// MARK: - Example Usage in ViewController
class WheelRatingVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UrbanistLabel!
    @IBOutlet weak var counter: UrbanistTextField!
    @IBOutlet weak var nextBtnTitle: UrbanistLabel!
    @IBOutlet weak var nextBtnArrow: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellFromNib(cellID: WheelRatingCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    var options = [["title": "Physical", "icon": "image 23", "color": "FFC7EB", "subtitle": "Exercise, nutrition, rest, body care."],
                   ["title": "Emotional", "icon": "image 24", "color": "FFD961", "subtitle": "Understanding and managing feelings."],
                   ["title": "Financial", "icon": "image 25", "color": "FFF7A0", "subtitle": "Money management, security, stress reduction."],
                   ["title": "Social", "icon": "image 26", "color": "FF91A9", "subtitle": "Relationships, connection, community."],
                   ["title": "Environmental", "icon": "image 27", "color": "00EDFB", "subtitle": "Surroundings, nature, impact."],
                   ["title": "Intellectual", "icon": "image 28", "color": "59C0FF", "subtitle": "Learning, creativity, mental challenges."],
                   ["title": "Occupational", "icon": "image 29", "color": "D4C4FF", "subtitle": "Fulfillment in work/daily activities."],
                   ["title": "Spiritual", "icon": "image 30", "color": "DEE6BD", "subtitle": "Purpose, values, beliefs, meaning."]]
    
    private var customPicker: CustomPickerView!
    private var resultLabel: UILabel!
    fileprivate var currentOptionIndex: Int = 1
    // Next or Generate My Wheel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fullText = "Rate each dimension from 0–10"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Find range of "0–10"
        if let range = fullText.range(of: "0–10") {
            let nsRange = NSRange(range, in: fullText)
            
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor(named: "CB6B4D") ?? .orange, // choose your color
                range: nsRange
            )
        }
        
        titleLbl.attributedText = attributedString
        
        counter.text = "\(currentOptionIndex) of 8"
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: UIButton) {
        nextBtnTitle.text = "Next"
        nextBtnArrow.isHidden = false
        if currentOptionIndex < options.count {
            collectionView.scrollToItem(at: IndexPath(item: currentOptionIndex, section: 0), at: .centeredVertically, animated: false)
            currentOptionIndex += 1
            counter.text = "\(currentOptionIndex) of 8"
        } else {
            let destVC = AppStoryboards.main.storyboardInstance.instantiateViewController(withIdentifier: "WheelVisualizationVC") as! WheelVisualizationVC
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: true)
        }
        
        if currentOptionIndex == options.count {
            nextBtnTitle.text = "Generate My Wheel"
            nextBtnArrow.isHidden = true
        }
    }
}

// MARK: Delegates and DataSources
extension WheelRatingVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WheelRatingCell.identifier, for: indexPath) as! WheelRatingCell
        let details = options[indexPath.row]
        let icon = details["icon"]
        let title = details["title"]
        let subtitle = details["subtitle"]
        let color = details["color"]
        cell.icon.image = UIImage(named: icon ?? "")
        cell.title.text = title
        cell.subTitle.text = subtitle
        cell.mainView.backgroundColor = UIColor(named: color ?? "")
        return cell
    }
}
