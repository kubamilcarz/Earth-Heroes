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
    @Published var isShowingCredits = false
    
    init() {
        self.questions = loadQuestions()
        loadGames()
    }
    
    deinit {
        saveGames()
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
    
    private func loadGames() {
        if let file = Bundle.main.url(forResource: "games", withExtension: "json") {
           do {
               let data = try Data(contentsOf: file)
               let decoder = JSONDecoder()
               let items = try decoder.decode([Game].self, from: data)
               self.games = items
           } catch {
               print("Error loading data: \(error.localizedDescription)")
           }
       } else {
           print("Could not find data.json in bundle.")
       }
    }
    
    func saveGames() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(games)
            let file = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("games.json")
            try data.write(to: file)
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    // tabs and pages
    @Published var currentPage: HeroPage? = nil
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
