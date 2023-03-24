//
//  AppViewModel.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

final class AppViewModel: ObservableObject {
    
    // data
    @Published var questions: [Question] = []
    
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
            return try decoder.decode([Question].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
        
        return []
    }
    
    
    // tabs and pages
    @Published var currentPage: HeroPage? = .game
    @Published var tabSelection: TabBarItem = .game
    
    func changePage(to newPage: HeroPage?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                self.currentPage = newPage
            }
        }
    }
}
