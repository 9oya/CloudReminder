//
//  NotiTableCell.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/06.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

let notiTalbeCellId = "NotiTableCellId"

class NotiTableCell: UITableViewCell {
    // MARK: Properties
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var underLineView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotiTableCell {
    private func setupLayout() {
        // MARK: Setup super-view
        selectionStyle = .none
        backgroundColor = ColorCompatibility.systemBackground
        
        // MARK: Setup sub-view properties
        titleLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 22, weight: .bold)
            label.textAlignment = .left
            label.textColor = ColorCompatibility.label
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        subTitleLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textAlignment = .left
            label.textColor = ColorCompatibility.label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        underLineView = {
            let view = UIView()
            view.backgroundColor = ColorCompatibility.systemGray5
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        // MARK: Setup UI Hierarchy
        addSubview(subTitleLabel)
        addSubview(titleLabel)
        addSubview(underLineView)
        
        // MARK: Setup constraints
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        underLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        underLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        underLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        underLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

