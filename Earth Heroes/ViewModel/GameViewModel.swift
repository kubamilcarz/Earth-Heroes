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
    @Published var isShowingGameSummary = false
    @AppStorage("GameCardsPerGame") var cardCountPerGame = 10
    @AppStorage("GameAutomaticallyShowFunfacts") var automaticallyShowFunfacts = true
    
    @Published var chosenAnswer = ""
    @Published var currentQuestion: Question?

    @Published var isCorrect: Bool?
    @Published var roundNumber = 0
    @Published var badCount = 0
    @Published var correctCount = 0
    
    
    init() {
        let shuffledQuestions = Array(loadQuestions().shuffled().prefix(cardCountPerGame))
        questions = shuffledQuestions
        if !shuffledQuestions.isEmpty {
            currentQuestion = shuffledQuestions[0]
        }
        
    }
    
    private func loadQuestions() -> [Question] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("Error loading JSON file.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Question].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
        
        return []
    }
    
    func checkAnswer() {
        guard let currentQuestion, !chosenAnswer.isEmpty else { return }
        
        self.isCorrect = chosenAnswer == getCorrectAnswer()
    }
    
    func getCorrectAnswer() -> String {
        guard let currentQuestion else { return "" }
        
        switch currentQuestion.correctAnswer {
        case .a:
            return currentQuestion.answerA
        case .b:
            return currentQuestion.answerB
        case .c:
            return currentQuestion.answerC
        case .d:
            return currentQuestion.answerD
        }
    }
    
    func resetVariables() {
        chosenAnswer = ""
        isCorrect = nil
    }
    
    func getNextQuestion() {
        guard roundNumber <= cardCountPerGame else {
            withAnimation {
                isShowingGameSummary = true
                
                
            }
            return
        }
        
        // if current question exist and if index exists
        if let lastQuestion = currentQuestion,
           let index = questions.firstIndex(where: { $0 == lastQuestion }) {
            
            // check answers and add points accordingly
            withAnimation {
                roundNumber += 1
                if chosenAnswer == lastQuestion.correctAnswerText {
                    // correct
                    correctCount += 1
                } else {
                    // false
                    badCount += 1
                }
            }
            
            // if it's the last question
            if index >= questions.count-1 {
                withAnimation {
                    isShowingGameSummary = true
                }
            } else {
                withAnimation {
                    currentQuestion = questions[index+1]
                }
            }
        }
        
        resetVariables()
    }
    
    func resetGame() {
        
        // save current game
        let newGame = Game(id: UUID(), playDate: Date.now, score: Double(correctCount)/Double(cardCountPerGame))
        
        AppViewModel.shared.games.append(newGame)
        AppViewModel.shared.saveGames()
        
        // reset
        roundNumber = 0
        badCount = 0
        correctCount = 0
        isCorrect = nil
        chosenAnswer = ""
        
        questions = Array(loadQuestions().shuffled().prefix(cardCountPerGame))
        
        currentQuestion = questions[0]
        isShowingGameSummary = false
    }
    
}
