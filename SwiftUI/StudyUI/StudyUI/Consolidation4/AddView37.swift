//
//  AddView37.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/13.
//

import SwiftUI

struct AddView37: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text:  self.$name)
                Picker("Type", selection: self.$type) {
                    ForEach(self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: self.$amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: self.amount)
                    self.expenses.items.append(item)
                    self.dismiss()
                }
            }
        }
    }
}

struct AddView37_Previews: PreviewProvider {
    static var previews: some View {
        AddView37(expenses: Expenses())
    }
}
