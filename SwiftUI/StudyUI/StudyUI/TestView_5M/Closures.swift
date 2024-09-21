//
//  Closures.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/05/10.
//

import SwiftUI

struct Closures: View {
    var list: [Int] = [1,2,3,4,5,6,2,3,1,2,41,2,4,1]
    var closures: (Int, Int) -> Int = { x, y in
        return x + y
    }
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // function body goes here
    }
    
    var body: some View {
        Button{
            _ = self.closures(4,5)
        } label: {
            Text("Closures")
        }
    }
}

struct Closures_Previews: PreviewProvider {
    static var previews: some View {
        Closures()
    }
}
