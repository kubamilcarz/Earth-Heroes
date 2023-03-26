//
//  Game.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

// Game Object
// Used for gameplays, scoreboard, and determining achievements

struct Game: Identifiable, Codable, Equatable {
    var id: UUID
    var playDate: Date
    var score: Double
}
