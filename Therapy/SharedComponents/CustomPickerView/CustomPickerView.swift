//
//  CustomPickerView.swift
//  Therapy
//
//  Created by iOS Developer on 07/01/26.
//

import Foundation

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
        
        backgroundColor = .clear
        clipsToBounds = true
        
        setupTableView()
        setupSelectionOverlay()
        setupGradients()
    }
    
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
        //selectionOverlay.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.3)
        //selectionOverlay.layer.cornerRadius = 8
        selectionOverlay.isUserInteractionEnabled = false
        addSubview(selectionOverlay)
    }
    
    private func setupGradients() {
        topGradient = CAGradientLayer()
        topGradient.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.systemBackground.withAlphaComponent(0).cgColor
        ]
        // layer.addSublayer(topGradient)
        
        bottomGradient = CAGradientLayer()
        bottomGradient.colors = [
            UIColor.systemBackground.withAlphaComponent(0).cgColor,
            UIColor.systemBackground.cgColor
        ]
        // layer.addSublayer(bottomGradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        
        tableView.frame = bounds
        tableView.backgroundColor = .clear
        
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
