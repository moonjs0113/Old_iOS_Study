//
//  Day57.swift
//  StudyUI2
//
//  Created by Moon Jongseek on 2022/04/01.
//

import SwiftUI
import CoreData

struct Day57: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    // predicate
    //    NSPredicate(format: "universe == 'Star Wars'")
    //    NSPredicate(format: "universe == %@", "Star Wars"))
    //    NSPredicate(format: "name < %@", "F")) // return Defiant, Enterprise, Executor
    //    NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"]) // 세개 중 하나
    //    NSPredicate(format: "name BEGINSWITH %@", "E") // E로 시작하는 단어
    //    NSPredicate(format: "name BEGINSWITH[c] %@", "e") // E 대소문자 무시
    //    NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e") // 위에거 반대
    
    @State private var lastNameFilter = "A"
    
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        TabView {
            VStack(spacing: 20) {
                List(self.wizards, id: \.self) { wizard in
                    Text(wizard.name ?? "Unknown")
                }
                Button("Add") {
                    let wizard = Wizard(context: self.moc)
                    wizard.name = "Harry Potter"
                }
                Button("Save") {
                    do {
                        try self.moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    //            if self.moc.hasChanges {
                    //
                    //            }
                }
            }.tabItem {
                Text("Wizard")
            }
            
            VStack(spacing: 20) {
                List(self.ships, id: \.self) { ship in
                    Text(ship.name ?? "Unknown name")
                }
                
                Button("Add Examples") {
                    let ship1 = Ship(context: self.moc)
                    ship1.name = "Enterprise"
                    ship1.universe = "Star Trek"
                    
                    let ship2 = Ship(context: self.moc)
                    ship2.name = "Defiant"
                    ship2.universe = "Star Trek"
                    
                    let ship3 = Ship(context: self.moc)
                    ship3.name = "Millennium Falcon"
                    ship3.universe = "Star Trek"
                    
                    let ship4 = Ship(context: self.moc)
                    ship4.name = "Executor"
                    ship4.universe = "Star Trek"
                    
                    try? moc.save()
                }
            }.tabItem {
                Text("Ship")
            }
            
            VStack(spacing: 20) {
                FilteredList(filter: self.lastNameFilter)
                
                FilteredList2(filterKey: "lastName", filterValue: self.lastNameFilter) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
                
                Button("Add Examples") {
                    let taylor = Singer(context: self.moc)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"
                    
                    let ed = Singer(context: self.moc)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"
                    
                    let adele = Singer(context: self.moc)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"
                    
                    try? self.moc.save()
                }
                
                Button("Show A") {
                    self.lastNameFilter = "A"
                }
                
                Button("Show S") {
                    self.lastNameFilter = "S"
                }
            }.tabItem {
                Text("Singer")
            }
            
            VStack {
                List {
                    ForEach(self.countries, id: \.self) { country in
                        Section(country.wrappedFullName) {
                            ForEach(country.candyArray, id: \.self) { candy in
                                Text(candy.wrappedName)
                            }
                        }
                    }
                }
                
                Button("Add") {
                    let candy1 = Candy(context: moc)
                    candy1.name = "Mars"
                    candy1.origin = Country(context: moc)
                    candy1.origin?.shortName = "UK"
                    candy1.origin?.fullName = "United Kingdom"
                    
                    let candy2 = Candy(context: moc)
                    candy2.name = "KitKat"
                    candy2.origin = Country(context: moc)
                    candy2.origin?.shortName = "UK"
                    candy2.origin?.fullName = "United Kingdom"
                    
                    let candy3 = Candy(context: moc)
                    candy3.name = "Twix"
                    candy3.origin = Country(context: moc)
                    candy3.origin?.shortName = "UK"
                    candy3.origin?.fullName = "United Kingdom"
                    
                    let candy4 = Candy(context: moc)
                    candy4.name = "Toblerone"
                    candy4.origin = Country(context: moc)
                    candy4.origin?.shortName = "CH"
                    candy4.origin?.fullName = "Switzerland"
                    
                    try? moc.save()
                }
            }.tabItem {
                Text("Candy")
            }
            
        }
    }
}

struct FilteredList2<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        List(self.fetchRequest, id: \.self) { singer in
            self.content(singer)
            //            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}

struct FilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        List(self.fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    init(filter: String) {
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}

struct Day57_Previews: PreviewProvider {
    static var previews: some View {
        Day57()
    }
}
