//
//  UserInterfaceElements.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/24.
//

import SwiftUI

struct UserInterfaceElements: View {
   
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                TextInputAndOutput()
                ControlsAndIndicators()
            }
        }
    }
}

struct TextInputAndOutput: View {
    @State var textField: String = ""
    @State var textInputAutocapitalization: String = ""
    @State var secureField: String = ""
    @State var textEditor: String = "Write Text"
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Text Input and Output")
                .font(.title)
            Text("I'm Text")
                .textSelection(.enabled)
            Label("I'm Label", systemImage: "tray.fill")
            TextField("PlaceHolder", text: self.$textField)
            TextField("PlaceHolder with TextInputAutocapitalization",
                      text: self.$textInputAutocapitalization)
                .textInputAutocapitalization(.words)
            SecureField("PlaceHolder Secure", text: self.$secureField)
            TextEditor(text: self.$textEditor)
        }
    }
}

struct ControlsAndIndicators: View {
    @State var sliderValue: Float = 5.0
    @State var stepperValue: Int = 0
    @State var toggleValue: Bool = false
    @State var pickerValue: Int = 0
    @State var datePicker: Date = Date.now
    @State var colorPicker: Color = .white
    @State var progressValue = 0.05
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 10) {
                Text("Controls and Indicators")
                    .font(.title)
                Button("Button") {
                    print("Button")
                }
                EditButton()
                if let url = URL(string: "https://apple.com/kr") {
                    Link("Apple", destination: url)
                }
                Menu("Menu") {
                    Text("Menu Text 1")
                    Button("Menu Button 1") {

                    }
                    Text("Menu Text 2")
                    Button("Menu Button 2") {

                    }
                    EditButton()
                    if let url = URL(string: "https://naver.com") {
                        Link("Naver", destination: url)
                    }
                }
                
                Slider(value: self.$sliderValue, in: 1...10, step: 0.5) {
                    Text("Slider Value: \(self.sliderValue)")
                }
                
                Stepper(value: self.$stepperValue, step: 1) {
                    Text("Stepper Value: \(self.stepperValue)")
                }
                
                Toggle(isOn: self.$toggleValue) {
                    Text("Toggle Value: \(String(self.toggleValue))")
                }
            }
            
            VStack(spacing: 10) {
                Picker("Menu Picker", selection: self.$pickerValue) {
                    ForEach(0..<101) { per in
                        Text(per, format: .percent)
                    }
                }
                .pickerStyle(.menu)
                
                NavigationLink("Inline Picker") {
                    List {
                        Picker("Inline Picker", selection: self.$pickerValue) {
                            ForEach(0..<5) { per in
                                Text(per, format: .percent)
                            }
                        }
                        .pickerStyle(.inline)
                        Text("Picker in List")
                    }
                }

                Picker("Wheel Picker", selection: self.$pickerValue) {
                    ForEach(0..<101) { per in
                        Text(per, format: .percent)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 50)
                .clipped()
//                .scaleEffect(CGSize(width: 1, height: 1.5))

                Picker("Segmented Picker", selection: self.$pickerValue) {
                    ForEach(0..<5) { per in
                        Text(per, format: .percent)
                    }
                }
                .pickerStyle(.segmented)

                DatePicker("Compact DatePicker", selection: self.$datePicker, displayedComponents: .date)
                    .datePickerStyle(.compact)

                DatePicker("Wheel DatePicker", selection: self.$datePicker, displayedComponents: .date)
                    .datePickerStyle(.wheel)

                DatePicker("Graphical DatePicker", selection: self.$datePicker, displayedComponents: .date)
                    .datePickerStyle(.graphical)

                DatePicker("Compact HourAndMinute DatePicker", selection: self.$datePicker, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)

                DatePicker("Wheel HourAndMinute DatePicker", selection: self.$datePicker, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)

                DatePicker("Graphical HourAndMinute DatePicker", selection: self.$datePicker, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.graphical)
            }
            VStack(spacing: 10) {
                ColorPicker("Color Picker", selection: self.$colorPicker)
                    .pickerStyle(.menu)

                ProgressView(value: self.progressValue)
                    .progressViewStyle(.linear)
                ProgressView(value: self.progressValue)
                    .progressViewStyle(.circular)

                Button("Progress Value Up") {
                    Timer.scheduledTimer(withTimeInterval: 0.125, repeats: true) { timer in
                        self.progressValue += 0.01
                        if self.progressValue == 1 {
                            timer.invalidate()
                        }
                    }
                }
            }
        }
    }
}

struct UserInterfaceElements_Previews: PreviewProvider {
    static var previews: some View {
        UserInterfaceElements()
    }
}


