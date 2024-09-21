//
//  Day50.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/03/23.
//

import SwiftUI

class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if self.specialRequestEnabled == false {
                self.extraFrosting = false
                self.addSprinkles = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if self.name.isEmpty || self.streetAddress.isEmpty || self.city.isEmpty || self.zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(self.quantity) * 2
        cost += (Double(self.type) / 2)
        
        if self.extraFrosting {
            cost += Double(self.quantity)
        }
            
        if self.addSprinkles {
            cost += Double(self.quantity) / 2
        }
        
        return cost
    }
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.quantity, forKey: .quantity)
        
        try container.encode(self.extraFrosting, forKey: .extraFrosting)
        try container.encode(self.addSprinkles, forKey: .addSprinkles)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.streetAddress, forKey: .streetAddress)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(Int.self, forKey: .type)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        
        self.extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        self.addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.streetAddress = try container.decode(String.self, forKey: .streetAddress)
        self.city = try container.decode(String.self, forKey: .city)
        self.zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() {
        
    }
}

struct Day50: View {
    @StateObject var order = Order()
    
    var body: some View {
//        NavigationView {
        Form {
            Section {
                Picker("Select your cake type", selection: self.$order.type) {
                    ForEach(Order.types.indices) {
                        Text(Order.types[$0])
                    }
                }
                
                Stepper("Number of cakes: \(self.order.quantity)", value: self.$order.quantity, in: 3...20)
            }
            
            Section {
                Toggle("Any special requests?", isOn: self.$order.specialRequestEnabled.animation())
                if self.order.specialRequestEnabled {
                    Toggle("Add extra frosting", isOn: self.$order.extraFrosting)
                    Toggle("Add extra sprinkles", isOn: self.$order.addSprinkles)
                }
            }
            
            Section {
                NavigationLink{
                    AddressView(order: self.order)
                } label: {
                    Text("Deliver details")
                }
            }
        }
        .navigationTitle("Cupcake Corner")
//    }
    }
}

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: self.$order.name)
                TextField("Street Address", text: self.$order.streetAddress)
                TextField("City", text: self.$order.city)
                TextField("Zip", text: self.$order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: self.order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(self.order.hasValidAddress == false)
        }
        .navigationTitle("Deliver details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(self.order) else {
            print("Failed to encode order")
            return
        }
        
        if let url = URL(string: "https://reqres.in/api/cupcakes") {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            do {
                let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
                
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } catch {
                print("Checkout failed.")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://www.hackingwithswift.com/samples/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(self.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await self.placeOrder()
                    }
                }
                .padding()
            }
        }
        .alert("Thank you!!", isPresented: self.$showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(self.confirmationMessage)
        }
    }
}

struct Day50_Previews: PreviewProvider {
    static var previews: some View {
        Day50()
    }
}
