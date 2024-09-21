//
//  Day37.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/08.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(self.items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                self.items = decodedItems
                return
            }
        }
        self.items = []
    }
}

struct Day37: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        self.expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.expenses.items) { item in
//                    Text(item.name)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text(item.amount, format:  .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    self.showingAddExpense = true
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    self.expenses.items.append(expense)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: self.$showingAddExpense) {
            AddView37(expenses: self.expenses)
        }
    }
}

struct Day37_Previews: PreviewProvider {
    static var previews: some View {
        Day37()
    }
}
