//
//  Day39_2.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/14.
//

import SwiftUI

struct Day39_2: View {
    var body: some View {
        NavigationView {
            List(0..<15) { row in
                NavigationLink {
                    Text("Detail \(row)")
                } label: {
                    Text("row \(row)")
                }
            }
            .navigationTitle("SwiftUI Day39")
        }
    }
}

struct Day39_2_Previews: PreviewProvider {
    static var previews: some View {
        Day39_2()
    }
}
