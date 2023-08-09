//
//  TimerView.swift
//  CitroHacksTimer
//
//  Created by Parineeta Padgilwar on 7/15/23.
//

import SwiftUI
import UIKit

struct TimerView: View {
    @State var currTimer: TimerModel = TimerModel.all[0]
    
    @EnvironmentObject var TimerVM: TimerViewModel
    
    @State var timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    @State var timerCounter: Int = 0
    @State var completedTimer: Bool = false
    @State var alertClicked: Bool = true
    @State var showTimerCreate: Bool = false
    @State var cycles: Int = 1
    
    var body: some View {
        NavigationView{
            ScrollView{
                //MARK: Title Timer
                Text("\(currTimer.name)")
                    .bold()
                    .font(.system(size: 20))
                    .fontDesign(.monospaced)
                    .padding()
                    .background((LinearGradient(gradient: Gradient(colors: [Color(.red).opacity(0.9), Color(.orange).opacity(0.8)]), startPoint: .topLeading, endPoint: .bottom)))
                    .cornerRadius(10)
                    .padding(.vertical, 30)
                
                //MARK: Actual Timer
                ZStack {
                    Text(counterToMinutes())
                        .font(.system(size: 30))
                        .fontDesign(.monospaced)
                        .bold()
                    
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 200, height: 200)
                        .overlay(
                            Circle().stroke(Color.black, lineWidth: 15)
                        )
                    
                    
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 200, height: 200)
                        .overlay(
                            Circle().trim(from:0, to: CGFloat(timerCounter) / CGFloat(currTimer.studyTime))
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 15,
                                        lineCap: .round,
                                        lineJoin:.round
                                    )
                                )
                                .foregroundColor(
                                    (timerCounter / currTimer.studyTime >= 1 ? Color.green : Color.orange)
                                ).animation(.linear(duration: 1.0))
                        )
                    
                }.padding(.bottom, 20)
                    .alert("Next!", isPresented: $completedTimer) {
                        Button("Continue", role: .cancel){
                            if(TimerVM.plantGrowth < 12)
                            {
                                TimerVM.plantGrowth = TimerVM.plantGrowth + 1
                            }
                            alertClicked = true
                            timerCounter = 0
                            let tempStudy = currTimer.studyTime
                            currTimer.studyTime = currTimer.breakTime ?? 500
                            currTimer.breakTime = tempStudy
                            
                        }
                    }
                HStack{
                    Button{
                        timerCounter = currTimer.studyTime
                    }label: {
                        Text("End Timer")
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                            .padding(.vertical, 20)
                    }
                    /*
                    Picker(selection: $cycles) {
                        ForEach(1..<4){number in
                            Text("\(number) Cycles").tag(number)
                        }
                    } label: {
                        Text("Set Cycles")
                        .bold()
                        .padding()
                        .cornerRadius(10)
                        .padding(.vertical, 20)
                            
                    }
*/
                   

                }
                
                //MARK: GridStuff
                Text("Productivity Timers")
                    .foregroundColor(.black)
                    .bold()
                    .fontDesign(.monospaced)
                    .padding(10)
                    .background(.red.opacity(0.7))
                    .border(.black, width: 3)
                    .cornerRadius(5)
                    .frame(maxHeight: 40)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10){
                    ForEach(TimerVM.timerList, id: \.self){ tm in
                        
                        Button(){
                            timerCounter = 0
                            currTimer = tm
                            
                        }label: {
                            Text("\(tm.name)")
                                .foregroundColor(.black)
                                .bold()
                                .fontDesign(.monospaced)
                                .padding(10)
                                .background(.red.opacity(0.7))
                                .cornerRadius(10)
                                .frame(maxHeight: 40)
                        }
                    }
                    Button {
                        showTimerCreate.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.black)
                        .frame(maxWidth: 40)
                    }
                }.padding()
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity)
                .sheet(isPresented: $showTimerCreate) {
                    TimerCreate()
                }
                
                
                
            }.onReceive(timer, perform: { time in
                if(timerCounter < currTimer.studyTime && !completedTimer){
                    timerCounter = timerCounter + 1
                }
            })
            .navigationTitle("Timers")
            .background(.orange.opacity(0.2))
        }
    }
    
    
    
    func counterToMinutes() -> String{
        
        let currTime = currTimer.studyTime - timerCounter
        let seconds = currTime % 60
        let minutes = Int(currTime / 60) % 60
        let hours = Int(currTime / 3600)
        DispatchQueue.main.async {
            if(currTimer.studyTime <= timerCounter && alertClicked){
                alertClicked = false
                completedTimer.toggle()
            }
        }
        return "\(hours):\(minutes):\(seconds)"
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
            TimerView()
                .environmentObject(TimerViewModel())
    }
}
