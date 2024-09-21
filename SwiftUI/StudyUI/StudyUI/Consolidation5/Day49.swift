//
//  Day49.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/03/22.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

class User49: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let contanier = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try contanier.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}

struct Day49: View {
    @State private var results = [Result]()
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        self.username.count < 5 || self.email.count < 5
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodeResponse = try? JSONDecoder().decode(Response.self, from: data) {
                self.results = decodeResponse.results
            } else {
                print("Decode Fail")
            }
        } catch {
            print("Invalid data")
        }
    }
    
    var body: some View {
        Form {
            Section {
                List(self.results, id: \.trackId) { item in
                    VStack(alignment: .leading) {
                        Text(item.trackName)
                            .font(.headline)
                        Text(item.collectionName)
                    }
                    .task {
                        await self.loadData()
                    }
                }
                
                AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 1) { phase in
                    phase
                        .resizable()
                        .scaledToFit()
//                    if let image = phase.image {
//                        image
//                            .resizable()
//                            .scaledToFit()
//                    } else if phase.error != nil {
//                        Text("There was an error loading the image.")
//                    } else {
//                        ProgressView()
//                    }
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
            }
            
            
            
            Section {
                TextField("Username", text: self.$username)
                TextField("Email", text: self.$email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(self.disableForm)
            
            NavigationLink("Day50", destination: Day50())
        }
    }
}

struct Day49_Previews: PreviewProvider {
    static var previews: some View {
        Day49()
    }
}
