//
//  Day53.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/03/24.
//

import SwiftUI
import CoreData

//struct Student53 {
//    var id: UUID
//    var name: String
//}

//class DataController: ObservableObject {
//    let container = NSPersistentContainer(name: "Bookworm")
//
//    init() {
//        self.container.loadPersistentStores { description, error in
//            if let error = error {
//                print("Core Data Failed to load: \(error.localizedDescription)")
//            }
//        }
//    }
//}

struct Day53: View {
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student53>
    
    @State private var showingDay54 = false
    
    var body: some View {
        VStack {
            Toggle("Remember Me", isOn: self.$rememberMe)
            PushButton(title: "Remember Me Button", isOn: self.$rememberMe)
            
            VStack {
                Text(self.rememberMe ? "On" : "Off")
                
                TextEditor(text: self.$notes)
                    .padding()
            }
            
//            NavigationLink("Day54", destination: Day54())
            Button("Day54") {
                self.showingDay54.toggle()
            }
            .sheet(isPresented: self.$showingDay54) {
                Day54()
            }
            
            Form {
                List(self.students) { student in
                    Text(student.name ?? "Unknown")
                }
                
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirstName = firstNames.randomElement() ?? ""
                    let chosenLastName = lastNames.randomElement() ?? ""
                    
                    let student = Student53(context: self.moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"
                    
                    try? moc.save()
                }
            }
        }
        .navigationTitle("Notes")
    }
}

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors: [Color] = [.red, .yellow]
    var offColors: [Color] = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(self.title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: self.isOn ? self.onColors : self.offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: self.isOn ? 0 : 5)
    }
}

struct Day53_Previews: PreviewProvider {
    static var previews: some View {
        Day53()
    }
}
