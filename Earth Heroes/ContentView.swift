//
//  ContentView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/23/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appVM = AppViewModel()
    
    @State private var tabSelection: TabBarItem = .game
    
    var body: some View {
        CustomTabBarContainerView(selection: $appVM.tabSelection) {
            GameView()
                .tabBarItem(tab: .game, selection: $appVM.tabSelection)
            FunfactsView()
                .tabBarItem(tab: .funfacts, selection: $appVM.tabSelection)
        }
        .environmentObject(appVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
