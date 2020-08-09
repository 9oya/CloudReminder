//
//  NotiDetailTableFooter.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/08.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

let notiDetailTableFooterId = "notiDetailTableFooterId"

class NotiDetailTableFooter: UITableViewHeaderFooterView {
    var guideLabel: UILabel!
    var notiSwitch: UISwitch!
    var underLineView: UIView!
    var deleteButton: UIButton!
    
    var switchChangedAction: ((_ isOn: Bool) -> Void)? = nil
    var deleteButtonTappedAction: (() -> Void)? = nil
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchChanged(uiSwitch: UISwitch) {
        switchChangedAction?(uiSwitch.isOn)
    }
    
    @objc func deleteButtonTapped() {
        deleteButtonTappedAction?()
    }
}

extension NotiDetailTableFooter {
    private func configureContents() {
        contentView.backgroundColor = ColorCompatibility.systemBackground
        
        guideLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.textColor = ColorCompatibility.label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        notiSwitch = {
            let uiSwitch = UISwitch()
            uiSwitch.onTintColor = .systemTeal
            uiSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            uiSwitch.translatesAutoresizingMaskIntoConstraints = false
            return uiSwitch
        }()
        underLineView = {
            let view = UIView()
            view.backgroundColor = ColorCompatibility.systemGray5
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        deleteButton = {
            let button = UIButton()
            button.setTitle("Delete", for: .normal)
            button.backgroundColor = .systemYellow
            button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        contentView.addSubview(guideLabel)
        contentView.addSubview(notiSwitch)
        contentView.addSubview(underLineView)
        contentView.addSubview(deleteButton)
        
        guideLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        guideLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        notiSwitch.centerYAnchor.constraint(equalTo: guideLabel.centerYAnchor, constant: 0).isActive = true
        notiSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        underLineView.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        underLineView.leadingAnchor.constraint(equalTo: guideLabel.leadingAnchor, constant: 0).isActive = true
        underLineView.trailingAnchor.constraint(equalTo: notiSwitch.trailingAnchor, constant: 0).isActive = true
        underLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: underLineView.bottomAnchor, constant: 30).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
