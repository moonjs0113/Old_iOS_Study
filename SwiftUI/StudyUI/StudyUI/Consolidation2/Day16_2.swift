//
//  ContentView16p2.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/18.
//

import SwiftUI

struct Day16_2: View {
    // @State랑 같음 UI 입력 포커싱에 쓰임
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Int = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let tipValue = (self.checkAmount / 100) * Double(self.tipPercentage)
        let grandTotal = self.checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let amountPerPerson = self.totalAmount / Double(self.numberOfPeople + 2)
        
        return amountPerPerson
    }
    
    let formatterUSD: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        Form {
            Group{
                Section {
                    // Locale 지역 클래스
                    TextField("Amount", value: self.$checkAmount, format: self.formatterUSD, prompt: Text("Prompt Text - Placeholder"))
                        .keyboardType(.decimalPad)
                        .focused(self.$amountIsFocused)
                    // NavigationView로 감싸줘야 하지만,
                    // Navigation에서 넘어온거라 안해줘도 작동함
                    Picker("Number Of People", selection: self.$numberOfPeople){
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Text("Not Real Title")
                    Picker("Tip Percentage", selection: self.$tipPercentage) {
                        ForEach(self.tipPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                    
                    Picker("Tip Percentage", selection: self.$tipPercentage) {
                        ForEach(0..<101) { per in
                            Text(per, format: .percent)
                        }
                    }
                } header: {
                    // Section Title 붙이는 법
                    Text("Real Section Title")
                }
                
                Section {
                    Text(self.totalPerPerson, format: self.formatterUSD)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(self.totalAmount, format: self.formatterUSD)
                } header: {
                    Text("Total Amount")
                        .foregroundColor(self.tipPercentage == 0 ? .red : .black)
                }
                
            }
            NavigationLink(destination: ChallengeView()) {
                Text("Go to Challenge")
            }
        }
        .navigationTitle("SwiftUI Day16 - part 2")
        .navigationBarTitleDisplayMode(.large)
        // ToolBar를 붙일 수 있음 -> Navigation View에만 붙일 수 있나?
        // ToolbarItemPlacement
        .toolbar {
            // Tool Bar Group 지정
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    self.amountIsFocused = false
                }
            }
        }
    }
}

struct ContentView16p2_Previews: PreviewProvider {
    static var previews: some View {
        Day16_2()
    }
}
