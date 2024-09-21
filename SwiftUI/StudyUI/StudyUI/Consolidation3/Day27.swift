//
//  Day27.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/02.
//

import CoreML
import SwiftUI

struct Day27: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    // static 변수 초기화 전에 사용가능한데, 대신 self 뺴야함
    // $변수를 통한 값 변경은 didSet, willSet을 호출하지 않음
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert: Bool = false
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: self.wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: self.sleepAmount, coffee: Double(self.coffeeAmount))
            
            let sleepTime = self.wakeUp - prediction.actualSleep
            self.alertTitle = "Your ideal bedtime is..."
            self.alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch (let error) {
            print(error)
            self.alertTitle = "Error"
            self.alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        self.showingAlert = true
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: self.$wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("Choose Wake Up Time")
                }
                
                Section {
                    VStack {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper("\(self.sleepAmount.formatted()) hours", value: self.$sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    VStack {
                        Text("Daily coffee intake")
                            .font(.headline)
                        Picker("Number of Cups", selection: self.$coffeeAmount) {
                            ForEach(1..<21) { cups in
                                Text(cups == 1 ? "1 cup" : "\(cups) cups")
                            }
                        }
                    }
                } header: {
                    Text("Set Value")
                }
                
                Section {
                    HStack {
                        Text("Your ideal bedtime is")
                        Text("\(self.alertMessage)")
                    }
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Project 4 - BetterRest")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 버튼을 없애고, 항상 시간이 표시되도록 하는 것 고민해보기
                Button("Calculate", action: self.calculateBedTime)
            }
            .alert(self.alertTitle, isPresented: self.$showingAlert){
                Button("OK") {}
            } message: {
                Text(self.alertMessage)
            }
        }
    }
}

struct Day27_Previews: PreviewProvider {
    static var previews: some View {
        Day27()
    }
}
