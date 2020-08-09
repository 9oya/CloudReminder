//
//  NotiDetailViewModel.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/09.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation
import RxSwift

class NotiDetailViewModel {
    let disposeBag = DisposeBag()
    
    var title: String!
    var content: String!
    var daysOfWeekDict: [Int: Bool]!
    var isOn: Bool!
    var hour: Int = 0
    var minute: Int = 0
    
    let titleInputText: BehaviorSubject<String> = BehaviorSubject(value: "CloudReminder")
    let contentInputText: BehaviorSubject<String> = BehaviorSubject(value: "")
    let timeInputDate: BehaviorSubject<Date> = BehaviorSubject(value: Date())
    let daysOfWeekInputDict: BehaviorSubject<[Int: Bool]> = BehaviorSubject(value: [1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true])
    let isOnInput: BehaviorSubject<Bool> = BehaviorSubject(value: true)
    
    let hourAndMinute: BehaviorSubject<(Int, Int)> = BehaviorSubject(value: (0, 0))
    
    init() {
        // INPUT
        timeInputDate
            .map { DateHelper.shared.convertDateToHourAndMinute(date: $0) }
            .bind(to: hourAndMinute)
            .disposed(by: disposeBag)
        
        // OUTPUT
        titleInputText
            .subscribe(onNext: { (title) in
                self.title = title
            }).disposed(by: disposeBag)
        
        contentInputText
            .subscribe(onNext: { (content) in
                self.content = content
            }).disposed(by: disposeBag)
        
        daysOfWeekInputDict
            .subscribe(onNext: { (daysOfWeekDict) in
                self.daysOfWeekDict = daysOfWeekDict
            }).disposed(by: disposeBag)
        
        isOnInput
            .subscribe(onNext: { (isOn) in
                self.isOn = isOn
            }).disposed(by: disposeBag)
        
        hourAndMinute
            .subscribe(onNext: { (hour, minute) in
                self.hour = hour
                self.minute = minute
            }).disposed(by: disposeBag)
    }
}
