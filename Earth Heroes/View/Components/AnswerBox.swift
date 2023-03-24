//
//  AnswerBox.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct AnswerBox: View {
    @EnvironmentObject var gameVM: GameViewModel
    @State private var isTapped = false
    
    var title: String
    var icon: String
    
    init(_ title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
    
    var body: some View {
        ZStack {
            Rectangle().fill(.regularMaterial)
            
            if gameVM.isCorrect == nil && gameVM.chosenAnswer == title {
                LinearGradient(colors: [Color.accentColor.opacity(0.7), Color.accentColor], startPoint: .bottomLeading, endPoint: .topTrailing)
            }
            
            if let isCorrect = gameVM.isCorrect {
                if gameVM.correctAnswer == title {
                    LinearGradient(colors: [Color.green.opacity(0.4), Color.green.opacity(0.8)], startPoint: .bottomLeading, endPoint: .topTrailing)
                }
                
                if !isCorrect && gameVM.chosenAnswer == title {
                    LinearGradient(colors: [Color.red.opacity(0.4), Color.red.opacity(0.8)], startPoint: .bottomLeading, endPoint: .topTrailing)
                }
            }
            
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.title2.bold())
                    .foregroundStyle(gameVM.chosenAnswer == title ? .primary : .secondary)
                
                Text(title)
                    .font(.custom(HeroFont.light.rawValue, size: 18))
                
                Spacer()
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 20)
        .onTapGesture {
            withAnimation {
                if gameVM.isCorrect == nil {
                    gameVM.chosenAnswer = title
                }
            }
        }
    }
}
