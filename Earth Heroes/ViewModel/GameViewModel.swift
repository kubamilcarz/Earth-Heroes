//
//  GameViewModel.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

class GameViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    
    @Published var isShowingGameSettings = false
    
    @Published var chosenAnswer = ""
    @Published var correctAnswer = "Zanieczyszczenie wody"
    @Published var funFact: String? = "Zmiany klimatyczne to efekt działalności człowieka uwalniającego gazy cieplarniane do atmosfery."
    @Published var isCorrect: Bool?
    
    init() {
        self.questions = loadQuestions()
    }
    
    private func loadQuestions() -> [Question] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("Error loading JSON file.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Question].self, from: data).shuffled()
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
        
        return []
    }
    
    func checkAnswer() {
        guard !chosenAnswer.isEmpty else { return }
        
        self.isCorrect = chosenAnswer == correctAnswer
    }
    
    func resetVariables() {
        chosenAnswer = ""
        isCorrect = nil
    }
    
    func getNextQuestion() {
        resetVariables()
    }
    
}
