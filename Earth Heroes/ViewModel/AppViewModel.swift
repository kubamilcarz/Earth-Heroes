//
//  AppViewModel.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

final class AppViewModel: ObservableObject {
    
    static let shared = AppViewModel()
    
    // data
    @Published var questions: [Question] = []
    @Published var games: [Game] = []
    @Published var currentQuestion: Question?
    
    @Published var isShowingSettings = false
    
    init() {
        self.questions = loadQuestions()
        self.games = loadGames()
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
    
    private func loadGames() -> [Game] {
        guard let url = Bundle.main.url(forResource: "games", withExtension: "json") else {
            print("Error loading JSON file.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Game].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
        
        return []
    }
    
    func saveGames() {
        guard let url = Bundle.main.url(forResource: "games", withExtension: "json") else {
            print("Error getting URL for JSON file.")
            return
        }

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(games)
            try data.write(to: url)
        } catch {
            print("Error encoding or writing JSON: \(error)")
        }
    }
    
    
    // tabs and pages
    @Published var currentPage: HeroPage? = .scoreboard
    @Published var tabSelection: TabBarItem = .game
    
    func changePage(to newPage: HeroPage?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                self.currentPage = newPage
            }
        }
    }
    
    
    var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
}
