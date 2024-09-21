//
//  Consolidation2.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/23.
//

import SwiftUI

struct Consolidation2: View, RSPDelegate {
    @State var actList: Array<String> = ["Rock", "Scissors", "Paper"].shuffled()
    @State var appAct: String = ""
    @State var goalResult: Bool = Bool.random()
    @State var gameCount: Int = 0
    @State var result: Bool = Bool.random()
    
    func sendAct(act: String) {
        self.appAct = self.actList[0]
        if self.appAct == "Rock" {
//            self.result = (act == "Scissors" ? : )
        }
        self.result = (act == self.appAct)
        
        self.actList.shuffle()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("App's Act: ")
                    .multilineTextAlignment(.leading)
                Text("\(self.actList[0])")
                    .multilineTextAlignment(.center)
            }
            Text("Goal: \(self.goalResult ? "Win" : "Lose")")
            ActButton(rpsDelegate: self)
            Text("\(self.result == self.goalResult ? "Win" : "Lose")")
        }
    }
}

protocol RSPDelegate {
    func sendAct(act: String) -> ()
}

struct ActButton: View {
    let actList: Array<String> = ["Rock", "Scissors", "Paper"]
    var rpsDelegate: RSPDelegate?
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(self.actList, id: \.self){ act in
                Button(act) {
                    self.rpsDelegate?.sendAct(act: act)
                }
            }
        }
    }
}

struct Consolidation2_Previews: PreviewProvider {
    static var previews: some View {
        Consolidation2()
    }
}
