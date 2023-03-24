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
                        .frame(maxHeight: 50)
                    
                    TopBar
                        .frame(maxHeight: 50)
                }
                
                Spacer()
            }
            
            if gameVM.isShowingGameSettings {
                ZStack {
                    Rectangle().fill(.ultraThinMaterial.opacity(0.7))
                    
                    VStack {
                        PageBar("Settings") {
                            gameVM.isShowingGameSettings = false
                        }
                        
                        Text("Number of questions per game\n\nAutomatically move to the next question\n\nSet Langugae")
                        
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
            
            if isShowingFunFactSheet && gameVM.funFact != nil {
                ZStack {
                    Rectangle().fill(.ultraThinMaterial.opacity(0.7))
                    
                    VStack {
                        PageBar("Fun Fact", isFunFact: true) {
                            isShowingFunFactSheet = false
                        }
                        if let funfact = gameVM.funFact {
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
        }
        .environmentObject(gameVM)
    }
    
    private var TopBar: some View {
        HStack(spacing: 15) {
            Rectangle().fill(.clear).frame(width: 30, height: 30)
            
            VStack(spacing: 7) {
                Text("Quiz")
                    .font(.custom(HeroFont.light.rawValue, size: 18))
                
                ZStack(alignment: .leading) {
                    Capsule().fill(.ultraThinMaterial)
                        .frame(height: 5)
                    Capsule().fill(LinearGradient(colors: [.accentColor, .mint], startPoint: .bottomLeading, endPoint: .topTrailing))
                        .frame(width: 110, height: 5)
                }
                
            }
            
            Button { withAnimation { gameVM.isShowingGameSettings = true } } label: {
                Image(systemName: "pause.fill")
                    .font(.title3)
                .frame(width: 30, height: 30) }
            
        }
        .padding()
    }
    
    private var ActualGame: some View {
        
        VStack(spacing: 30) {
            ZStack(alignment: .bottom) {
                Image("climate")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .clipped()
                
                ScrollView {
                    VStack(spacing: 30) {
                        QuestionBox
                            .padding(.top, 75)
                        
                        VStack(spacing: 20) {
                            AnswerBox("Zanieczyszczenie powietrza", icon: "a.square")
                            AnswerBox("Zanieczyszczenie wody", icon: "b.square")
                            AnswerBox("Zanieczyszczenie hałasem", icon: "c.square")
                            AnswerBox("Zanieczyszczenie światłem", icon: "d.square")
                        }
                        .padding(.bottom, 100)
                    }
                    .frame(maxWidth: 550)
                }
               
                HeroButton(gameVM.isCorrect != nil ? "Next Question" : "Check Answer") {
                    if gameVM.isCorrect == nil {
                        withAnimation {
                            gameVM.checkAnswer()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                if gameVM.funFact != nil {
                                    isShowingFunFactSheet = true
                                }
                            }
                        }
                        
                    } else {
                        gameVM.getNextQuestion()
                    }
                }
                .padding([.horizontal, .bottom])
                .frame(maxWidth: 550)
            }
        }
    }
    
    private var QuestionBox: some View {
        VStack(spacing: 20) {
            Image(systemName: "wind")
                .font(.title.bold())
                .foregroundColor(.accentColor)
            
            Text("Jakie zanieczyszczenia spowodowane sa nadmiernym stosowaniem nawozów i pestycydów w rolnictwie?")
                .font(.custom(HeroFont.regular.rawValue, size: 19))
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(maxWidth: 550)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView()
    }
}
