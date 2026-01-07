//
//  PickerCell.swift
//  Therapy
//
//  Created by iOS Developer on 07/01/26.
//

import Foundation

import UIKit

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
