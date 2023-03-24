//
//  GameView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var appVM: AppViewModel
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
            
            LinearGradient(colors: [.white.opacity(0.2), .clear], startPoint: .top, endPoint: .bottom)
            
            ScrollView {
                VStack(spacing: 50) {
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220)
                        .padding(.top, 100)
                    
                    VStack(spacing: 20) {
                        HeroButton("New Game", icon: "play") {
                            appVM.changePage(to: .game)
                        }
                        
                        HeroButton("Scoreboard", icon: "list.bullet.rectangle.portrait") {
                            appVM.changePage(to: .scoreboard)
                        }
                    }
                    
                    VStack(spacing: 20) {
                        HeroButton("Achievements", icon: "trophy", style: .secondary) {
                            appVM.changePage(to: .achievements)
                        }
                        
                        HeroButton("Settings", icon: "gear", style: .secondary) {
                            appVM.changePage(to: .settings)
                        }
                    }
                    
                    Spacer()
                    
                    Spacer()
                }
                .frame(maxWidth: 350)
                .padding(.horizontal, 50)
            }
            
            if let page = appVM.currentPage {
                GeometryReader { geo in
                    VStack {
                        Spacer(minLength: 70)
                        
                        HStack {
                            Spacer()
                            Group {
                                switch page {
                                case .game:
                                    GameplayView()
                                case .scoreboard:
                                    ScoreboardView()
                                case .achievements:
                                    AchievementsView()
                                case .settings:
                                    SettingsView()
                                }
                            }
                            .frame(width: geo.size.width - 50)
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .black.opacity(0.1), radius: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 120)
                    }
                    .frame(height: geo.size.height)
                }
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                .environmentObject(appVM)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
        .ignoresSafeArea()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
