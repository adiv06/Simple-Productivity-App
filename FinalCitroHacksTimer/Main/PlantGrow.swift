//
//  PlantGrow.swift
//  FinalCitroHacksTimer
//
//  Created by Parineeta Padgilwar on 7/16/23.
//

import SwiftUI

struct PlantGrow: View {
    @EnvironmentObject var timerVM: TimerViewModel
    var counter: Int {timerVM.plantGrowth}
    var imageDisplay: Image {let im = Image("Stage\(counter/2)")
        return im
    }

    var body: some View {
        
        VStack{
            Spacer()
            Text("Progress Plant")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .bold()
                .padding()
                .background(.black)
                .cornerRadius(10)
            
            Spacer()
            
            
        imageDisplay
                .animation(.easeInOut(duration: 0.5))
            Spacer()
            
            Text("You have completed \(counter) timers!")
                .foregroundColor(.white)
                .bold()
                .padding()
                .background(.green.opacity(0.7))
                .cornerRadius(10)

            
    }
    }
}

struct PlantGrow_Previews: PreviewProvider {
    static var previews: some View {
        PlantGrow().environmentObject(TimerViewModel())
    }
}
