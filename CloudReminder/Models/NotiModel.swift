//
//  NotiModel.swift
//  EasyNoti
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

struct NotiModel: Codable {
    var id: String
    var title: String
    var body: String
    var hour: Int
    var minute: Int
    var weekCode: Int
}
