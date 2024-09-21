//
//  Day30.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/03.
//

import SwiftUI

struct Day30: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    func addNewWord() {
        let answer = self.newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isShortOrRoot(word: answer) else {
            self.wordError(title: "Word is so short or root word",
                           message: "Be change!")
            return
        }
        
        guard isOriginal(word: answer) else {
            self.wordError(title: "Word used already",
                           message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            self.wordError(title: "Word not possible",
                           message: "You can't spell that word from '\(self.rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            self.wordError(title: "Word not recognized",
                           message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation{
            self.usedWords.insert(answer, at: 0)
            self.score += answer.count
        }
        self.newWord = ""
    }
    
    func startGame() {
        withAnimation{
            self.score = 0
            self.usedWords = [String]()
        }
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                let allWords = fileContents.components(separatedBy: "\n")
                self.rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isShortOrRoot(word: String) -> Bool {
        (word.count > 2) && (word != self.rootWord)
    }
    
    func isOriginal(word: String) -> Bool {
        !self.usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = self.rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        self.errorTitle = title
        self.errorMessage = message
        self.showingError = true
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Score: \(self.score)")
                    TextField("Enter your word", text: self.$newWord)
                        .autocapitalization(.none)
                    //                        .onSubmit { self.addNewWord() }
                }
                
                Section {
                    ForEach(self.usedWords, id: \.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .alert(self.errorTitle, isPresented: self.$showingError){
                Button("OK", role: .cancel) {}
            } message: {
                Text(self.errorMessage)
            }
        }
        .navigationTitle(self.rootWord)
        .onSubmit(self.addNewWord)
        .onAppear(perform: self.startGame)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("New Game") {
                    self.startGame()
                }
            }
        }
    }
}

struct Day30_Previews: PreviewProvider {
    static var previews: some View {
        Day30()
    }
}
