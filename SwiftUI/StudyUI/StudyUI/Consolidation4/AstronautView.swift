//
//  AstronautView.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/16.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(self.astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(self.astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: self.astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
