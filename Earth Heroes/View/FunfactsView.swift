//
//  FunfactsView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct FunfactsView: View {
    @EnvironmentObject var appVM: AppViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
            
            LinearGradient(colors: [.white.opacity(0.2), .clear], startPoint: .top, endPoint: .bottom)
            
            GeometryReader { geo in
                HStack {
                    Spacer()
                    
                    ScrollView {
                        VStack(spacing: 50) {
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(.regularMaterial)
                                    .shadow(color: .black.opacity(0.5), radius: 0, y: 10)
                                
                                VStack(spacing: 20) {
                                    if let question = appVM.currentQuestion {
                                        Image(systemName: question.category.icon)
                                            .font(.title.bold())
                                            .foregroundColor(question.category.color)
                                        
                                        Text(question.funFact)
                                            .font(.custom(HeroFont.light.rawValue, size: 19))
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(20)
                            }
                            .frame(maxWidth: 550)
                            .padding(.horizontal, 50)
                            .padding(.top, 75)
                            
                            Spacer()
                        }
                        
                    }
                    .frame(height: geo.size.height)
                    
                    Spacer()
                }
                
            }
            
            HeroButton("Next", icon: "sparkles") {
                withAnimation {
                    appVM.currentQuestion = appVM.questions.shuffled().first
                }
            }
            .frame(maxWidth: 550)
            .padding(.bottom, appVM.idiom == .pad ? 100 : 115)
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
        .onAppear {
            while appVM.currentQuestion?.funFact.isEmpty ?? true {
                appVM.currentQuestion = appVM.questions.shuffled().first
            }
        }
    }
}

struct FunfactsView_Previews: PreviewProvider {
    static var previews: some View {
        FunfactsView()
    }
}
