//
//  Day26.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/27.
//

import SwiftUI

struct Day26: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    func exampleDates() {
        let now = Date.now
        let tomorrowFromNow = now.addingTimeInterval(86400)
        let _ = now...tomorrowFromNow
        
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 0
        let _ = Calendar.current.date(from: dateComponents) ?? now
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 10) {
                VStack{
                    Stepper("\(self.sleepAmount) hours", value: self.$sleepAmount)
                Stepper("\(self.sleepAmount) hours\nin 4...12", value: self.$sleepAmount, in: 4...12)
                Stepper("\(self.sleepAmount) hours\nin 4...12, step: 0.25", value: self.$sleepAmount, in: 4...12, step: 0.25)
                Stepper("\(self.sleepAmount.formatted()) hours\nin 4...12, step: 0.25 with formatted()", value: self.$sleepAmount, in: 4...12, step: 0.25)
                    
                }
                
                VStack {
                    DatePicker("Please enter a date", selection: $wakeUp)
                    DatePicker("", selection: $wakeUp)
                    DatePicker("Please enter a date", selection: $wakeUp)
                        .labelsHidden()
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
                }
                
                VStack {
                    Text(Date.now, format:  .dateTime.hour().minute())
                    Text(Date.now, format:  .dateTime.day().month().year())
                    Text(Date.now.formatted(date: .long, time: .shortened))
                }
                NavigationLink("CoreML", destination: Day27())
            }
        }
    }
}

struct Day26_Previews: PreviewProvider {
    static var previews: some View {
        Day26()
    }
}
