//
//  TimerCreate.swift
//  CitroHacksTimer
//
//  Created by Parineeta Padgilwar on 7/15/23.
//

import SwiftUI

struct TimerCreate: View {
    
    @EnvironmentObject var timerVM: TimerViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var selection: String = "Work"
    
    @State var workHours: Int = 0
    @State var workMinutes: Int = 0
    @State var breakHours: Int = 0
    @State var breakMinutes: Int = 0
    @State var work: Bool = true
    @State var timerName: String = ""

    
    let options: [String] = ["Work", "Break"]
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.red.withAlphaComponent(0.3)
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center){
                Spacer()
                VStack(alignment: .leading, spacing: 0){
                    Text("Timer Name")
                        .bold()
                    TextField("Enter the timer name...", text: $timerName)
                        .padding()
                        .background(.gray.opacity(0.1))
                        .frame(maxWidth: UIScreen.main.bounds.width - 40)
                        .cornerRadius(15)
                }
                
                Picker(selection: $selection) {
                    ForEach(options.indices){index in
                        Text("\(options[index])")
                            .tag(options[index])
                    }
                } label: {
                    Text("Picker")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                let work = selection == "Work"
                HStack{
                    Spacer()
                    VStack {
                        Text("Hours")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(.black)
                            .cornerRadius(10)
                        
                        if(work)
                        {
                            Picker(selection: $workHours) {
                                ForEach(0..<24){number in
                                    Text("\(number)")
                                        .tag(number)
                                }
                            } label: {
                                Text("Picker")
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                        }
                        else{
                            Picker(selection: $breakHours) {
                                ForEach(0..<24){number in
                                    Text("\(number)")
                                        .tag(number)
                                }
                            } label: {
                                Text("Picker")
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                        }
                        Text("Work Time")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                            .padding(.vertical, 20)
                        
                        Text("\(workHours):\(workMinutes)")
                            .font(.system(size: 40))
                            .bold()
                            
                    }
                    
                    
                    Spacer()
                    VStack {
                        Text("Minutes")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(.black)
                            .cornerRadius(10)
                        
                        if(work)
                        {
                            Picker(selection: $workMinutes) {
                                ForEach(0..<60){number in
                                    Text("\(number)")
                                        .tag(number)
                                }
                            } label: {
                                Text("Picker")
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                        }
                        else{
                            Picker(selection: $breakMinutes) {
                                ForEach(0..<60){number in
                                    Text("\(number)")
                                        .tag(number)
                                }
                            } label: {
                                Text("Picker")
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                        }
                        Text("Break Time")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                            .padding(.vertical, 20)
                        
                        Text("\(breakHours):\(breakMinutes)")
                            .font(.system(size: 40))
                            .bold()
                    }
                    Spacer()
                }
                Spacer()
                Button {
                    timerVM.addTimer(tm: TimerModel(studyTime: workHours * 3600 + workMinutes * 60, breakTime: breakHours * 3600 + breakMinutes * 60, name: timerName))
                    dismiss()
                } label: {
                    HStack{
                        Text("Create")
                            .bold()
                            .foregroundColor(.white)
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.horizontal, 100)
                    .background(.blue)
                    .cornerRadius(10)
                }

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(){
                        dismiss()
                    } label: {
                        Label("Cancel", systemImage: "xmark")
                            .labelStyle(.iconOnly).foregroundColor(.black)
                        
                    }
                }
            }
        }
    }
    }


struct TimerCreate_Previews: PreviewProvider {
    static var previews: some View {
        TimerCreate()
            .environmentObject(TimerViewModel())
    }
}
