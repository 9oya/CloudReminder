//
//  UITextField+AddLeftPadding.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/09.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
