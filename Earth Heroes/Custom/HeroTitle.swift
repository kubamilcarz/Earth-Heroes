//
//  HeroTitle.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct HeroTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("LondrinaSolid-Regular", size: 26))
    }
}

extension View {
    func heroTitle() -> some View {
        modifier(HeroTitle())
    }
}
