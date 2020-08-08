//
//  NotiDetailTableCell.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

let notiDetailTalbeCellId = "NotiDetailTableCellId"

class NotiDetailTableCell: UITableViewCell {
    // MARK: Properties
    var guideLabel: UILabel!
    var contentLabel: UILabel!
    var underLineView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotiDetailTableCell {
    private func setupLayout() {
        // MARK: Setup super-view
        selectionStyle = .none
        backgroundColor = ColorCompatibility.systemBackground
        
        // MARK: Setup sub-view properties
        guideLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.textAlignment = .left
            label.textColor = ColorCompatibility.label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        contentLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 22, weight: .light)
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
        addSubview(guideLabel)
        addSubview(contentLabel)
        addSubview(underLineView)
        
        // MARK: Setup constraints
        guideLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        guideLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        contentLabel.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 10).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        underLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        underLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        underLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        underLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

