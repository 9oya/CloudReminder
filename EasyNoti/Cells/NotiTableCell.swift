//
//  NotiTableCell.swift
//  EasyNoti
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

let notiTalbeCellId = "NotiTableCellId"

class NotiTableCell: UITableViewCell {
    // MARK: Properties
    
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
        backgroundColor = .clear
        
        // MARK: Setup sub-view properties
        
        // MARK: Setup UI Hierarchy
        
        // MARK: Setup constraints
    }
}

