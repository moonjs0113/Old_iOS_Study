//
//  Day40.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/15.
//

import SwiftUI

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var formattedLaunchDate: String {
        self.launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
}

extension Bundle {
//    func decode(_ file: String) -> [String:Astronaut] {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate \(file) from bundle.")
        }
        
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        //        [String: Astronaut].self -> T.self
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}

struct Day40: View {
    let astronauts: [String:Astronaut] = Bundle.main.decode("astronauts.json")
    let missoins: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: self.columns) {
                    ForEach(self.missoins) { mission in
                        NavigationLink {
                            Day41(mission: mission, astronauts: self.astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding([.horizontal, .bottom])
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
        }
        .background(.darkBackground)
//        Text("\(self.astronauts.count)")
    }
}

struct Day40_Previews: PreviewProvider {
    static var previews: some View {
        Day40()
    }
}
