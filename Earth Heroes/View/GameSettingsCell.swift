//
//  GameSettingsCell.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/26/23.
//

import SwiftUI

struct GameSettingsCell: View {
    
    @AppStorage("GameCardsPerGame") var cardCountPerGame = 10
    @AppStorage("GameAutomaticallyShowFunfacts") var automaticallyShowFunfacts = true
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("How many questions?")
                    .font(.custom(HeroFont.light.rawValue, size: 18))
                Spacer()
                Picker("How many questions?", selection: $cardCountPerGame) {
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("15").tag(15)
                    Text("20").tag(20)
                }
                .pickerStyle(.menu)
                .labelsHidden()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(.ultraThinMaterial, lineWidth: 1)
                        .allowsHitTesting(false)
                )
            }
            
            HStack {
                Text("Automatically show fun facts")
                    .font(.custom(HeroFont.light.rawValue, size: 18))
                
                Spacer()
                
                Toggle("Automatically show fun facts", isOn: $automaticallyShowFunfacts)
                    .labelsHidden()
            }
        }
        .padding(.vertical, 30)
        .padding(.horizontal)
    }
}

struct GameSettingsCell_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsCell()
    }
}
