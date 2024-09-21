//
//  ChallengeView.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/19.
//

import SwiftUI

struct ChallengeView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var inputValue: Double = 0.0
    @State private var inputUnit: String = "meters"
    @State private var outputUnit: String = "meters"
    let unitArray: Array<String> = ["meters", "kilometers", "feet", "yard", "miles", "inch"]
    let unitRate: Array<Double> = [1.0, 0.001, 3.28084, 1.09361, 0.000621371, 39.37008]
    
    var outputValue: Double {
        let meters: Double = self.calculateToMeters(self.inputUnit)
        let unitRate: Double = meters * self.unitRate[self.unitArray.firstIndex(of: self.outputUnit) ?? 0]
        let result: Double = unitRate * self.inputValue
        return result
    }
    
    func calculateToMeters(_ inputValue: String) -> Double {
        return self.inputValue / self.unitRate[self.unitArray.firstIndex(of: self.inputUnit) ?? 0]
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Input Unit", selection: self.$inputUnit){
                    ForEach(self.unitArray, id: \.self) {
                        Text("\($0)")
                    }
                }.pickerStyle(.segmented)
                TextField("input", value: self.$inputValue, format: .number)
                    .keyboardType(.decimalPad)
                    .focused(self.$amountIsFocused)
            } header: {
                Text("Input Unit")
            }
            
            Section {
                Picker("Output Unit", selection: self.$outputUnit){
                    ForEach(self.unitArray, id: \.self) {
                        Text("\($0)")
                    }
                }.pickerStyle(.segmented)
                Text(self.outputValue, format: .number)
            } header: {
                Text("Output Unit")
            }
        }
        .navigationTitle("Challenge View")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Hide Keyboard") {
                    self.amountIsFocused = false
                }
            }
        }
    }

}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
