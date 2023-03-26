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
        ZStack(alignment: .top) {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
            
            LinearGradient(colors: [.white.opacity(1), .clear], startPoint: .top, endPoint: .bottom)
            
            
            ScrollView {
                VStack(spacing: 50) {
                    Spacer()
                    
                    VStack(spacing: 50) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 270)
                            .padding(.top, appVM.isPortrait ? 100 : appVM.idiom == .pad ? 100 : 30)
                            .shadow(color: .black.opacity(0.2), radius: 0, y: 3)
                        
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
                                withAnimation {
                                    appVM.isShowingSettings = true
                                }
                            }
                        }
                    }
                    .frame(maxWidth: 350)
                    
                    Spacer()
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        appVM.isShowingCredits = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
                Spacer()
            }
            
            if appVM.isShowingSettings {
                ZStack {
                    Rectangle().fill(.ultraThinMaterial.opacity(0.7))
                        .onTapGesture {
                            withAnimation {
                                appVM.isShowingSettings = false
                            }
                        }
                    
                    VStack {
                        PageBar("Settings") {
                            appVM.isShowingSettings = false
                        }
                        
                        GameSettingsCell()
                    }
                    .padding()
                    .frame(maxWidth: 550)

                    .padding(.bottom, 30)
                    .background(.background, in: RoundedRectangle(cornerRadius: 18))
                    .padding()
                }
                .transition(.scale)
            }
            
            if let page = appVM.currentPage {
                GeometryReader { geo in
                    VStack {
                        Spacer(minLength: appVM.idiom == .pad ? 50 : 0)
                        
                        HStack(spacing: 0) {
                            Spacer(minLength: 0)
                            
                            Group {
                                switch page {
                                case .game:
                                    GameplayView()
                                        .preferredColorScheme(.light)
                                case .scoreboard:
                                    ScoreboardView()
                                case .achievements:
                                    AchievementsView()
                                case .settings:
                                    SettingsView()
                                }
                            }
                            .frame(width: geo.size.width - (appVM.idiom == .pad ? 50 : 0))
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .black.opacity(0.1), radius: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            Spacer(minLength: 0)
                        }
                            
                        Spacer(minLength: appVM.idiom == .pad ? 100 : 0)
                    }
                    .frame(height: geo.size.height)
                }
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                .environmentObject(appVM)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $appVM.isShowingCredits) {
            CreditsView()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
