////
////  ViewController.swift
////  Therapy
////
////  Created by iOS Developer on 30/12/25.
////
//
//import UIKit
//
//class WheelRatingVC: UIViewController {
//
//    @IBOutlet weak var titleLbl: UrbanistLabel!
//
//    private var customPicker: CustomPickerView!
//    private var resultLabel: UILabel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        let fullText = "Rate each dimension from 0–10"
//        let attributedString = NSMutableAttributedString(string: fullText)
//
//        // Find range of "0–10"
//        if let range = fullText.range(of: "0–10") {
//            let nsRange = NSRange(range, in: fullText)
//
//            attributedString.addAttribute(
//                .foregroundColor,
//                value: UIColor(named: "CB6B4D"), // choose your color
//                range: nsRange
//            )
//        }
//
//        titleLbl.attributedText = attributedString
//
//        setupPicker()
//        setupResultLabel()
//    }
//
//    private func setupPicker() {
//        customPicker = CustomPickerView(frame: CGRect(x: 40,
//                                                      y: 150,
//                                                      width: view.bounds.width - 80,
//                                                      height: 250))
//        customPicker.items = ["05", "06", "07", "08", "09", "10", "11", "12"]
//        customPicker.selectedRow = 2 // Select "07"
//
//        customPicker.onSelectionChanged = { [weak self] selectedIndex in
//            guard let self = self else { return }
//            self.resultLabel.text = "Selected: \(self.customPicker.items[selectedIndex])"
//        }
//
//        view.addSubview(customPicker)
//    }
//
//    private func setupResultLabel() {
//        resultLabel = UILabel()
//        resultLabel.text = "Selected: 07"
//        resultLabel.textAlignment = .center
//        resultLabel.font = .systemFont(ofSize: 76, weight: .bold)
//        resultLabel.frame = CGRect(x: 40, y: 420, width: view.bounds.width - 80, height: 40)
//        view.addSubview(resultLabel)
//    }
//
//    @IBAction func back(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//}
//
//import UIKit
//
//// MARK: - Custom Picker View
//class CustomPickerView: UIView {
//
//    // MARK: - Properties
//    private var tableView: UITableView!
//    private var selectionOverlay: UIView!
//    private var topGradient: CAGradientLayer!
//    private var bottomGradient: CAGradientLayer!
//
//    var items: [String] = [] {
//        didSet {
//            tableView.reloadData()
//            scrollToSelectedRow(animated: false)
//        }
//    }
//
//    var selectedRow: Int = 0 {
//        didSet {
//            scrollToSelectedRow(animated: true)
//            onSelectionChanged?(selectedRow)
//        }
//    }
//
//    var onSelectionChanged: ((Int) -> Void)?
//
//    private let rowHeight: CGFloat = 44
//
//    // MARK: - Initialization
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//
//    // MARK: - Setup
//    private func setupView() {
//        backgroundColor = .systemBackground
//        layer.cornerRadius = 12
//        clipsToBounds = true
//
//        setupTableView()
//        setupSelectionOverlay()
//        setupGradients()
//    }
//
//    private func setupTableView() {
//        tableView = UITableView(frame: bounds, style: .plain)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundColor = .clear
//        tableView.register(PickerCell.self, forCellReuseIdentifier: "PickerCell")
//        tableView.contentInset = UIEdgeInsets(top: bounds.height / 2 - rowHeight / 2,
//                                               left: 0,
//                                               bottom: bounds.height / 2 - rowHeight / 2,
//                                               right: 0)
//        addSubview(tableView)
//    }
//
//    private func setupSelectionOverlay() {
//        selectionOverlay = UIView()
//        selectionOverlay.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.3)
//        selectionOverlay.layer.cornerRadius = 8
//        selectionOverlay.isUserInteractionEnabled = false
//        addSubview(selectionOverlay)
//    }
//
//    private func setupGradients() {
//        topGradient = CAGradientLayer()
//        topGradient.colors = [
//            UIColor.systemBackground.cgColor,
//            UIColor.systemBackground.withAlphaComponent(0).cgColor
//        ]
//        layer.addSublayer(topGradient)
//
//        bottomGradient = CAGradientLayer()
//        bottomGradient.colors = [
//            UIColor.systemBackground.withAlphaComponent(0).cgColor,
//            UIColor.systemBackground.cgColor
//        ]
//        layer.addSublayer(bottomGradient)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        tableView.frame = bounds
//
//        let overlayHeight = rowHeight
//        let overlayY = (bounds.height - overlayHeight) / 2
//        selectionOverlay.frame = CGRect(x: 8, y: overlayY, width: bounds.width - 16, height: overlayHeight)
//
//        let gradientHeight: CGFloat = 60
//        topGradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: gradientHeight)
//        bottomGradient.frame = CGRect(x: 0, y: bounds.height - gradientHeight, width: bounds.width, height: gradientHeight)
//    }
//
//    private func scrollToSelectedRow(animated: Bool) {
//        guard selectedRow < items.count else { return }
//        let indexPath = IndexPath(row: selectedRow, section: 0)
//        tableView.scrollToRow(at: indexPath, at: .middle, animated: animated)
//    }
//
//    // MARK: - Public Methods
//    func selectRow(_ row: Int, animated: Bool) {
//        guard row < items.count else { return }
//        selectedRow = row
//        scrollToSelectedRow(animated: animated)
//    }
//}
//
//// MARK: - UITableViewDataSource
//extension CustomPickerView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! PickerCell
//        cell.configure(with: items[indexPath.row])
//        return cell
//    }
//}
//
//// MARK: - UITableViewDelegate
//extension CustomPickerView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return rowHeight
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedRow = indexPath.row
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        updateCellAppearance()
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            snapToNearestRow()
//        }
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        snapToNearestRow()
//    }
//
//    private func snapToNearestRow() {
//        let centerY = tableView.contentOffset.y + tableView.bounds.height / 2
//        let centerPoint = CGPoint(x: tableView.bounds.width / 2, y: centerY)
//
//        if let indexPath = tableView.indexPathForRow(at: centerPoint) {
//            selectedRow = indexPath.row
//        }
//    }
//
//    private func updateCellAppearance() {
//        let centerY = tableView.contentOffset.y + tableView.bounds.height / 2
//
//        for cell in tableView.visibleCells {
//            guard let pickerCell = cell as? PickerCell else { continue }
//
//            let cellCenterY = cell.frame.midY
//            let distance = abs(cellCenterY - centerY)
//            let maxDistance = rowHeight * 2
//
//            let scale = max(0.7, 1 - (distance / maxDistance) * 0.3)
//            let alpha = max(0.3, 1 - (distance / maxDistance) * 0.7)
//
//            pickerCell.transform = CGAffineTransform(scaleX: scale, y: scale)
//            pickerCell.alpha = alpha
//        }
//    }
//}
//
//// MARK: - Picker Cell
//class PickerCell: UITableViewCell {
//
//    private let label: UILabel = {
//        let lbl = UILabel()
//        lbl.textAlignment = .center
//        lbl.font = .systemFont(ofSize: 22, weight: .regular)
//        lbl.textColor = .label
//        return lbl
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupCell()
//    }
//
//    private func setupCell() {
//        backgroundColor = .clear
//        selectionStyle = .none
//        contentView.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
//        ])
//    }
//
//    func configure(with text: String) {
//        label.text = text
//    }
//}


import UIKit

// MARK: - Custom Picker View
class CustomPickerView: UIView {
    
    // MARK: - Properties
    private var tableView: UITableView!
    private var selectionOverlay: UIView!
    private var topGradient: CAGradientLayer!
    private var bottomGradient: CAGradientLayer!
    
    var items: [String] = [] {
        didSet {
            tableView.reloadData()
            scrollToSelectedRow(animated: false)
        }
    }
    
    var selectedRow: Int = 0 {
        didSet {
            scrollToSelectedRow(animated: true)
            onSelectionChanged?(selectedRow)
        }
    }
    
    var onSelectionChanged: ((Int) -> Void)?
    
    private let rowHeight: CGFloat = 128
    private let selectedFontSize: CGFloat = 76
    private let normalFontSize: CGFloat = 28
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        //backgroundColor = .systemBackground
        //layer.cornerRadius = 12
        clipsToBounds = true
        
        setupTableView()
        setupSelectionOverlay()
        setupGradients()
    }
    
    //    private func setupTableView() {
    //        tableView = UITableView(frame: bounds, style: .plain)
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //        tableView.separatorStyle = .none
    //        tableView.showsVerticalScrollIndicator = false
    //        tableView.backgroundColor = .clear
    //        tableView.register(PickerCell.self, forCellReuseIdentifier: "PickerCell")
    //        tableView.contentInset = UIEdgeInsets(top: bounds.height / 2 - rowHeight / 2,
    //                                              left: 0,
    //                                              bottom: bounds.height / 2 - rowHeight / 2,
    //                                              right: 0)
    //        addSubview(tableView)
    //    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        tableView.register(PickerCell.self, forCellReuseIdentifier: "PickerCell")
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupSelectionOverlay() {
        selectionOverlay = UIView()
        selectionOverlay.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.3)
        selectionOverlay.layer.cornerRadius = 8
        selectionOverlay.isUserInteractionEnabled = false
        addSubview(selectionOverlay)
    }
    
    private func setupGradients() {
        topGradient = CAGradientLayer()
        topGradient.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.systemBackground.withAlphaComponent(0).cgColor
        ]
        layer.addSublayer(topGradient)
        
        bottomGradient = CAGradientLayer()
        bottomGradient.colors = [
            UIColor.systemBackground.withAlphaComponent(0).cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.addSublayer(bottomGradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.frame = bounds
        
        let overlayHeight = rowHeight
        let overlayY = (bounds.height - overlayHeight) / 2
        selectionOverlay.frame = CGRect(x: 8, y: overlayY, width: bounds.width - 16, height: overlayHeight)
        
        let gradientHeight: CGFloat = 60
        topGradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: gradientHeight)
        bottomGradient.frame = CGRect(x: 0, y: bounds.height - gradientHeight, width: bounds.width, height: gradientHeight)
        
        // TODO:
        tableView.contentInset = UIEdgeInsets(
            top: bounds.height / 2 - rowHeight / 2,
            left: 0,
            bottom: bounds.height / 2 - rowHeight / 2,
            right: 0
        )
    }
    
    private func scrollToSelectedRow(animated: Bool) {
        guard selectedRow < items.count else { return }
        let indexPath = IndexPath(row: selectedRow, section: 0)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: animated)
    }
    
    // MARK: - Public Methods
    func selectRow(_ row: Int, animated: Bool) {
        guard row < items.count else { return }
        selectedRow = row
        scrollToSelectedRow(animated: animated)
    }
}

// MARK: - UITableViewDataSource
extension CustomPickerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! PickerCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        cell.configure(with: items[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CustomPickerView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCellAppearance()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapToNearestRow()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToNearestRow()
    }
    
    private func snapToNearestRow() {
        let centerY = tableView.contentOffset.y + tableView.bounds.height / 2
        let centerPoint = CGPoint(x: tableView.bounds.width / 2, y: centerY)
        
        if let indexPath = tableView.indexPathForRow(at: centerPoint) {
            selectedRow = indexPath.row
        }
    }
    
    private func updateCellAppearance() {
        let centerY = tableView.contentOffset.y + tableView.bounds.height / 2
        
        for cell in tableView.visibleCells {
            guard let pickerCell = cell as? PickerCell else { continue }
            
            let cellCenterY = cell.frame.midY
            let distance = abs(cellCenterY - centerY)
            let maxDistance = rowHeight * 2
            
            // Calculate scale (1.0 for center, 0.5 for far cells)
            let scale = max(0.5, 1 - (distance / maxDistance) * 0.5)
            
            // Calculate alpha (1.0 for center, 0.3 for far cells)
            let alpha = max(0.3, 1 - (distance / maxDistance) * 0.7)
            
            // Calculate font size (selectedFontSize for center, normalFontSize for far cells)
            let fontSize = normalFontSize + (selectedFontSize - normalFontSize) * (1 - distance / maxDistance)
            
            pickerCell.transform = CGAffineTransform(scaleX: scale, y: scale)
            pickerCell.alpha = alpha
            pickerCell.updateFontSize(fontSize)
            
            let isCentered = distance < rowHeight / 2
            pickerCell.setSelectedStyle(isCentered)
        }
    }
}

// MARK: - Picker Cell
class PickerCell2: UITableViewCell {
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 28, weight: .medium)
        lbl.textColor = .label
        return lbl
    }()
    
    private let pillView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with text: String) {
        label.text = text
    }
    
    func updateFontSize(_ size: CGFloat) {
        label.font = .systemFont(ofSize: size, weight: .medium)
    }
}

class PickerCell: UITableViewCell {
    
    private let pillView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 36
        view.clipsToBounds = true
        return view
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 28, weight: .medium)
        lbl.textColor = .systemGray
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(pillView)
        pillView.translatesAutoresizingMaskIntoConstraints = false
        
        pillView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Pill centered
            pillView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pillView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Pill size (matches screenshot style)
            pillView.heightAnchor.constraint(equalToConstant: 72),
            pillView.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            // Label inside pill
            label.centerXAnchor.constraint(equalTo: pillView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: pillView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: pillView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: pillView.trailingAnchor, constant: -24)
        ])
    }
    
    func configure(with text: String) {
        label.text = text
    }
    
    func setSelectedStyle(_ selected: Bool) {
        if selected {
            pillView.backgroundColor = UIColor(red: 0.67, green: 0.72, blue: 0.47, alpha: 1)
            label.textColor = .white
        } else {
            pillView.backgroundColor = .clear
            label.textColor = .systemGray
        }
    }
    
    func updateFontSize(_ size: CGFloat) {
        label.font = .systemFont(ofSize: size, weight: .medium)
    }
}


// MARK: - Example Usage in ViewController
class WheelRatingVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UrbanistLabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = .systemBackground
        
        //  setupPicker()
        // setupResultLabel()
        
        let fullText = "Rate each dimension from 0–10"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Find range of "0–10"
        if let range = fullText.range(of: "0–10") {
            let nsRange = NSRange(range, in: fullText)
            
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor(named: "CB6B4D"), // choose your color
                range: nsRange
            )
        }
        
        titleLbl.attributedText = attributedString
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        let rootVC = storyboard.instantiateViewController(withIdentifier: "TabbarsVC") as! TabbarsVC
       SharedMethods.shared.navigateToRootVC(rootVC: rootVC)
    }

    private func setupPicker() {
        customPicker = CustomPickerView(frame: CGRect(x: 40, y: 100, width: view.bounds.width - 80, height: 400))
        customPicker.items = ["05", "06", "07", "08", "09", "10", "11", "12"]
        customPicker.selectedRow = 2 // Select "07"
        
        customPicker.onSelectionChanged = { [weak self] selectedIndex in
            guard let self = self else { return }
            self.resultLabel.text = "Selected: \(self.customPicker.items[selectedIndex])"
        }
        
        view.addSubview(customPicker)
    }
    
    private func setupResultLabel() {
        resultLabel = UILabel()
        resultLabel.text = "Selected: 07"
        resultLabel.textAlignment = .center
        resultLabel.font = .systemFont(ofSize: 18, weight: .medium)
        resultLabel.frame = CGRect(x: 40, y: 520, width: view.bounds.width - 80, height: 40)
        view.addSubview(resultLabel)
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
