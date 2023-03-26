//
//  AchievementsView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var appVM: AppViewModel
    
    var body: some View {
        VStack {
            PageBar("Achievements")
                .padding(.top, appVM.idiom != .pad && appVM.isPortrait ? 50 : 0)
            
            Spacer()
        }
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
    }
}
