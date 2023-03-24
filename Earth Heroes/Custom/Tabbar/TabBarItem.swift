//
//  TabBarItem.swift
//  Read Us
//
//  Created by Kuba Milcarz on 9/25/22.
//

import SwiftUI

enum TabBarItem: Hashable {
    case game, funfacts
    
    var iconName: String {
        switch self {
        case .game: return "globe.europe.africa"
        case .funfacts: return "sparkles"
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .game: return "Game"
        case .funfacts: return "Fun Facts"
        }
    }
    
    var color: Color {
        .accentColor
    }
}
