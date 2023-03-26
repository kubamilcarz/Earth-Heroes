//
//  Question.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct Question: Identifiable, Codable, Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: Int
    var question: String
    var answerA: String
    var answerB: String
    var answerC: String
    var answerD: String
    var correctAnswer: CorrectAnswer
    var category: QuestionCategory
    var funFact: String
    var difficulty: QuestionDifficulty
    
    var correctAnswerText: String {
        switch correctAnswer {
        case .a:
            return answerA
        case .b:
            return answerB
        case .c:
            return answerC
        case .d:
            return answerD
        }
    }
}

enum CorrectAnswer: String, Codable {
    case a = "A", b = "B", c = "C", d = "D"
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
        case .foodWaste: return .orange
        case .recycling: return .green
        case .greenhouseGases: return .red
        }
    }
    
    var background: String {
        switch self {
        case .electricity: return "energy"
        case .pollution: return "pollution"
        case .foodWaste: return "foodWaste"
        case .recycling: return "recycling"
        case .greenhouseGases: return "greenhouse"
        }
    }
}
