//
//  GameplayView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct GameplayView: View {
    @EnvironmentObject var appVM: AppViewModel

    @StateObject var gameVM = GameViewModel()
    
    @State private var isShowingFunFactSheet = false
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .top) {
                    ActualGame
                    
                    Rectangle().fill(.regularMaterial)
                        .shadow(color: .black.opacity(0.1), radius: 15)
                        .frame(maxHeight: appVM.idiom == .pad ? 50 : appVM.isPortrait ? 110 : 50)
                    
                    TopBar
                        .frame(maxHeight: 50)
                        .padding(.top, appVM.idiom == .pad ? 0 : appVM.isPortrait ? 60 : 5)
                }
                
                Spacer()
            }
            
            if gameVM.isShowingGameSettings {
                ZStack {
                    Rectangle().fill(.ultraThinMaterial.opacity(0.7))
                        .onTapGesture {
                            withAnimation {
                                gameVM.isShowingGameSettings = false
                            }
                        }
                    
                    VStack {
                        PageBar("Settings") {
                            gameVM.isShowingGameSettings = false
                        }
                        
                        GameSettingsCell()
                        
                        HStack {
                            Spacer()
                            
                            Button("Quit") {
                                appVM.currentPage = nil
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal, 30)
                    }
                    .padding()
                    .frame(maxWidth: 550)

                    .padding(.bottom, 30)
                    .background(.background, in: RoundedRectangle(cornerRadius: 18))
                    .padding()
                }
                .transition(.scale)
            }
            
            if isShowingFunFactSheet && !(gameVM.currentQuestion?.funFact ?? "").isEmpty {
                ZStack {
                    Rectangle().fill(.ultraThinMaterial.opacity(0.7))
                        .onTapGesture {
                            withAnimation {
                                isShowingFunFactSheet = false
                            }
                        }
                    VStack {
                        PageBar("Fun Fact", isFunFact: true) {
                            withAnimation {
                                isShowingFunFactSheet = false
                            }
                        }
                        if let funfact = gameVM.currentQuestion?.funFact {
                            Text(funfact)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 30)
                                .padding(.horizontal)
                        }
                    }
                    .frame(maxWidth: 550)

                    .padding(.bottom, 30)
                    .background(.background, in: RoundedRectangle(cornerRadius: 18))
                    .padding()
                }
                .transition(.scale)
            }
            
            if gameVM.isShowingGameSummary {
                ZStack {
                    Rectangle().fill(.ultraThinMaterial.opacity(0.7))
                        .onTapGesture {
                            withAnimation {
                                gameVM.resetGame()
                            }
                        }
                    
                    VStack {
                        PageBar("Congratulations") {
                            withAnimation {
                                gameVM.resetGame()
                            }
                        }
                        
                        Text("\(gameVM.correctCount)/\(gameVM.cardCountPerGame)")
                            .foregroundColor(.accentColor)
                            .font(.custom(HeroFont.black.rawValue, size: 54))
                            .padding(.vertical, 30)
                        
                        HStack {
                            Spacer()
                            
                            Button("Quit") {
                                withAnimation {
                                    gameVM.resetGame()
                                    appVM.currentPage = nil
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal, 30)
                    }
                    .padding()
                    .frame(maxWidth: 550)

                    .padding(.bottom, 30)
                    .background(.background, in: RoundedRectangle(cornerRadius: 18))
                    .padding()
                }
                .transition(.scale)
            }
        }
        .environmentObject(gameVM)
    }
    
    private var TopBar: some View {
        HStack(spacing: 15) {
            Rectangle().fill(.clear).frame(width: 30, height: 30)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(.ultraThinMaterial)
                        .frame(height: 7)
                    Capsule().fill(LinearGradient(colors: [.accentColor, .mint], startPoint: .bottomLeading, endPoint: .topTrailing))
                        .frame(width: geo.size.width * CGFloat(gameVM.roundNumber)/CGFloat(gameVM.questions.count), height: 7)
                }
            }
            .frame(height: 7)
            
            Button { withAnimation { gameVM.isShowingGameSettings = true } } label: {
                Image(systemName: "pause.fill")
                    .font(.title3)
                .frame(width: 30, height: 30) }
            
        }
        .padding(.vertical)
        .padding(.horizontal, appVM.idiom == .pad ? 15 : appVM.isPortrait ? 15 : 30)
    }
    
    private var ActualGame: some View {
        
        VStack(spacing: 30) {
            ZStack(alignment: .bottom) {
                if let question = gameVM.currentQuestion {
                    Image(question.category.background)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                }
                
                ScrollView {
                    VStack(spacing: 30) {
                        QuestionBox
                            .padding(.top, appVM.idiom == .pad ? 75 : appVM.isPortrait ? 130 : 75)
                        
                        if let question = gameVM.currentQuestion {
                            VStack(spacing: 20) {
                                AnswerBox(question.answerA, question: .a)
                                    .frame(maxHeight: .infinity)
                                AnswerBox(question.answerB, question: .b)
                                    .frame(maxHeight: .infinity)
                                AnswerBox(question.answerC, question: .c)
                                    .frame(maxHeight: .infinity)
                                AnswerBox(question.answerD, question: .d)
                                    .frame(maxHeight: .infinity)
                            }
                            .fixedSize(horizontal: false, vertical: false)
                        }
                    }
                    .frame(maxWidth: 550)
                    .padding(.bottom, 100)

                }
               
                HeroButton(gameVM.isCorrect != nil ? "Next Question" : "Check Answer") {
                    if let question = gameVM.currentQuestion {
                        if gameVM.isCorrect == nil {
                            withAnimation {
                                gameVM.checkAnswer()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    if !question.funFact.isEmpty && gameVM.automaticallyShowFunfacts {
                                        isShowingFunFactSheet = true
                                    }
                                }
                            }
                            
                        } else {
                            if isShowingFunFactSheet == false {
                                gameVM.getNextQuestion()
                            }
                        }
                    }
                }
                .disabled(gameVM.chosenAnswer.isEmpty)
                .padding([.horizontal, .bottom])
                .frame(maxWidth: 550)
                .padding(.bottom, appVM.idiom == .pad ? 0 : 90)
            }
        }
    }
    
    private var QuestionBox: some View {
        VStack(spacing: 20) {
            if let question = gameVM.currentQuestion {
                Image(systemName: question.category.icon)
                    .font(.title.bold())
                    .foregroundColor(question.category.color)
                
                Text(question.question)
                    .font(.custom(HeroFont.light.rawValue, size: 19))
                    .multilineTextAlignment(.center)
            }
        }
        .padding(20)
        .frame(maxWidth: 550)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
        .onTapGesture {
            if !(gameVM.currentQuestion?.funFact ?? "").isEmpty {
                withAnimation {
                    isShowingFunFactSheet = true
                }
            }
        }
        .padding(.horizontal)
    }
}

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView()
    }
}
