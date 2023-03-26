//
//  ScoreboardView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct ScoreboardView: View {
    @EnvironmentObject var appVM: AppViewModel
    
    var body: some View {
        VStack {
            PageBar("Scoreboard")
                .padding(.top, appVM.idiom != .pad && appVM.isPortrait ? 50 : 0)
            
            VStack(spacing: 30) {
                if appVM.games.isEmpty {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .font(.largeTitle.bold())
                            .foregroundColor(.accentColor)
                        
                        Text("No games found")
                            .font(.custom(HeroFont.regular.rawValue, size: 24))
                            .foregroundStyle(.primary.opacity(0.7))
                    }
                } else {
                    ForEach(appVM.games) { game in
                        if let index = appVM.games.firstIndex(where: { $0 == game }) {
                            HStack {
                                Image(systemName: "\(index+1).square")
                                    .font(.title2.bold())
                                
                                Text("Score: \(game.score.formatted(.percent))")
                                    .font(.custom(HeroFont.regular.rawValue, size: 24))
                                
                                Spacer()
                                
                                Text(game.playDate.formatted(date: .abbreviated, time: .omitted))
                                    .font(.custom(HeroFont.light.rawValue, size: 18))
                                    .foregroundColor(.accentColor)
                            }
                            
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}
