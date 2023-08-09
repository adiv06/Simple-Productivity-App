//
//  ContentView.swift
//  FinalCitroHacksTimer
//
//  Created by Parineeta Padgilwar on 7/16/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerVM: TimerViewModel

    var body: some View {
        TabView{
            TimerView()
                .tabItem {
                    Label("Timers", systemImage: "timer")
                }
            PlantGrow()
                .tabItem {
                    Label("Plant Progress", systemImage: "leaf.arrow.circlepath")
                }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimerViewModel())
    }
}
