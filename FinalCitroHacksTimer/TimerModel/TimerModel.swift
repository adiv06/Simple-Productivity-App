//
//  TimerModel.swift
//  CitroHacksTimer
//
//  Created by Parineeta Padgilwar on 7/15/23.
//

import Foundation

struct TimerModel: Hashable{
    let id: String = UUID().uuidString
    var studyTime: Int
    var breakTime: Int?
    var name: String
    var cycles: Int?
}

extension TimerModel{
    static var all: [TimerModel] = [
    TimerModel(studyTime: 25 * 60, breakTime: 5 * 60, name: "Pomodoro", cycles: nil),
    TimerModel(studyTime: 90 * 60, breakTime: 30 * 60, name: "Ultradian", cycles: nil),
    TimerModel(studyTime: 52 * 60, breakTime: 17 * 60, name: "52:17", cycles: nil),
    //TimerModel(studyTime: 2 * 60, breakTime: -1, name: "Initiative", cycles: nil),
    TimerModel(studyTime: 45 * 60, breakTime: 15 * 60, name: "45:15", cycles: nil),
    //TimerModel(studyTime: -1, breakTime: nil, name: "Flow Time", cycles: nil),
    
    
    ]
}
