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
    var questionType: CorrectAnswer
    
    init(_ title: String, question: CorrectAnswer) {
        self.title = title
        self.questionType = question
    }
    
    var body: some View {
        ZStack {
            Rectangle().fill(.regularMaterial)
            
            if gameVM.isCorrect == nil && gameVM.chosenAnswer == title {
                LinearGradient(colors: [Color.accentColor.opacity(0.7), Color.accentColor], startPoint: .bottomLeading, endPoint: .topTrailing)
            }
            
            if let isCorrect = gameVM.isCorrect {
                if gameVM.getCorrectAnswer() == title {
                    LinearGradient(colors: [Color.green.opacity(0.4), Color.green.opacity(0.8)], startPoint: .bottomLeading, endPoint: .topTrailing)
                }
                
                if !isCorrect && gameVM.chosenAnswer == title {
                    LinearGradient(colors: [Color.red.opacity(0.4), Color.red.opacity(0.8)], startPoint: .bottomLeading, endPoint: .topTrailing)
                }
            }
            
            HStack(alignment: .top, spacing: 15) {
                Image(systemName: "\(questionType.rawValue.lowercased()).square")
                    .font(.title2.bold())
                    .foregroundStyle(gameVM.chosenAnswer == title ? .primary : .secondary)
                
                Text(title)
                    .lineLimit(5)
                    .font(.custom(HeroFont.light.rawValue, size: 18))

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
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
