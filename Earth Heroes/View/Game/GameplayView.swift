//
//  GameplayView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct GameplayView: View {
    @EnvironmentObject var appVM: AppViewModel
    
    var body: some View {
        VStack {
            PageBar("Game")
            
            Spacer()
        }
    }
}

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView()
    }
}
