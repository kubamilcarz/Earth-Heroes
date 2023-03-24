//
//  Question.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct Question: Identifiable, Codable {
    var id: Int
    var question: String
    var answerA: String
    var answerB: String
    var answerC: String
    var answerD: String
    var correctAnswer: String
    var category: QuestionCategory
    var funFact: String
    var difficulty: QuestionDifficulty
}

enum QuestionDifficulty: String, Codable {
    case easy, medium, hard
    
    init(from decoder: Decoder) {
        do {
            let intValue = try decoder.singleValueContainer().decode(Int.self)
            switch intValue {
            case 1:
                self = .easy
            case 2:
                self = .medium
            case 3:
                self = .hard
            default:
                self = .easy
            }
        } catch {
            self = .easy
        }
    }
}

enum QuestionCategory: String, Codable {
    case electricity
    case pollution
    case foodWaste = "food waste"
    case recycling
    case greenhouseGases = "greenhouse gases"
    
    var icon: String {
        switch self {
        case .electricity: return "bolt"
        case .pollution: return "drop"
        case .foodWaste: return "carrot"
        case .recycling: return "arrow.3.trianglepath"
        case .greenhouseGases: return "carbon.dioxide.cloud"
        }
    }
    
    var color: Color {
        switch self {
        case .electricity: return .yellow
        case .pollution: return .brown
        case .foodWaste: return .blue
        case .recycling: return .green
        case .greenhouseGases: return .red
        }
    }
}
