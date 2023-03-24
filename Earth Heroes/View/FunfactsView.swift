//
//  FunfactsView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct FunfactsView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
            
            LinearGradient(colors: [.white.opacity(0.2), .clear], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
    }
}

struct FunfactsView_Previews: PreviewProvider {
    static var previews: some View {
        FunfactsView()
    }
}
