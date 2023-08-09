//
//  TimerViewModel.swift
//  CitroHacksTimer
//
//  Created by Parineeta Padgilwar on 7/15/23.
//

import Foundation

class TimerViewModel: ObservableObject{
    
    @Published private(set) var timerList: [TimerModel] = []
    @Published var imageListString: [String] = []
    @Published var plantGrowth: Int = 2
    var value = 0.0
    
    init(){
        TimerModel.all.forEach { tm in
            timerList.append(tm)
        }
    }
    
    func addTimer(tm: TimerModel){
        timerList.append(tm)
    }
    
}

