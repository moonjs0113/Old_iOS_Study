//
//  Day21.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/20.
//

import SwiftUI

struct Day21: View, FlagDelegate {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingAnswer = false
    @State private var showingTotalScore = false
    
    @State private var alertMessage = ""
    
    @State private var myScore: Int = 0
    @State private var questionCount: Int = 1
    
    @State private var animationAmount = 0.0
    @State private var animationOpacity = 1.0
    
    func countQuestion() {
        if self.questionCount < 8 {
            self.questionCount += 1
        } else {
            self.showingTotalScore = true
        }
    }
    
    func flagTapped(_ number: Int) {
        if (number == self.correctAnswer) {
            self.myScore += 1
            withAnimation(.linear(duration: 1)){
                self.animationAmount += 360
                self.animationOpacity = 0.25
            }
            self.askQuestion()
        } else {
            self.alertMessage = "That’s the flag of \(self.countries[number])"
            self.showingAnswer = true
        }
    }
    
    func askQuestion() {
        withAnimation(.linear(duration: 1)){
            self.animationOpacity = 1
        }
        
        if !self.showingTotalScore {
            self.countQuestion()
            self.countries.shuffle()
            self.correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func initGame() {
        self.questionCount = 0
        self.myScore = 0
        self.askQuestion()
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                HStack(alignment: .center, spacing: 10) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(self.countries[self.correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(0..<3) { number in
                            let flagImage = FlagImage(index: number, flagDelegate: self)
                            flagImage
                                .rotation3DEffect(.degrees(self.animationAmount),
                                                  axis: (x: 0, y: 1, z: 0))
                                .opacity(self.animationOpacity)
                            //                            if number == self.correctAnswer {
                            //                                flagImage
                            //                                    .rotation3DEffect(.degrees(self.animationAmount),
                            //                                                           axis: (x: 0, y: 1, z: 0))
                            //                            } else {
                            //                                flagImage
                            //                            }
                            //
                            //                            flagImage
                        }
                    }
                }
                Text("\(self.questionCount) / 8")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }.alert("Wrong", isPresented: self.$showingAnswer) {
            Button("Continue", action: self.askQuestion)
        } message: {
            Text("\(self.alertMessage)")
        }.alert("End", isPresented: self.$showingTotalScore) {
            Button("Restart", action: self.initGame)
        } message: {
            Text("Your Score is \(self.myScore)!")
        }
    }
}

protocol FlagDelegate {
    var countries: [String] { get set }
    func flagTapped(_ number: Int) -> Void
}

struct FlagImage: View {
    var index: Int
    var flagDelegate: FlagDelegate
    
    var body: some View {
        Button {
            self.flagDelegate.flagTapped(self.index)
        } label: {
            Image(self.flagDelegate.countries[self.index])
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
                .frame(maxHeight: 100)
        }
    }
}


struct Day21_Previews: PreviewProvider {
    static var previews: some View {
        Day21()
    }
}
