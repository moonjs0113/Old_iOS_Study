//
//  ARCView.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/06/01.
//

import SwiftUI

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

struct ARCView: View {
    @State private var personList: [Person?] = []
    @State private var personName: String = ""
    private let num = 100000
    
    var body: some View {
        VStack{
            VStack(spacing: 10) {
                TextField("Person Name", text: $personName)
                Button("Print Reference Count") {
                    guard let firstPerson =  personList.first else {
                        return
                    }
                    print(CFGetRetainCount(firstPerson))
                    print(CFGetAllocator(firstPerson))
                }
                
                Button("Create Person") {
                    let newPerson: Person?  = Person(name: personName)
                    personList.append(newPerson)
                }
                
                Button("Create \(num) Person") {
                    let personCount = personList.count
                    for i in personCount+1...personCount+num {
                        let newPerson = Person(name: personName+"\(i)")
                        personList.append(newPerson)
                    }
                }
                Button("Clear Person") {
                    for _ in 0...personList.count-1 {
                        personList.removeLast()
                    }
                    
                }
                Divider()
            }
            Form {
                List {
                    ForEach(self.personList, id: \.?.name) { person in
                        Text("\(person?.name ?? "")'s Reference Count: \(CFGetRetainCount(person))")
                    }
                }
            }
        }
        .padding()
        
    }
}

struct ARCView_Previews: PreviewProvider {
    static var previews: some View {
        ARCView()
    }
}
