//
//  HeroButton.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

enum HeroButtonStyle {
    case primary, secondary
}

struct HeroButton: View {
    @State private var isTapped = false
    
    var title: LocalizedStringKey
    var icon: String?
    var style: HeroButtonStyle
    var action: () -> Void
    
    init(_ title: LocalizedStringKey, icon: String? = nil, style: HeroButtonStyle = .primary, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                if style == .primary {
                    LinearGradient(colors: [.accentColor.opacity(0.9), .mint.opacity(0.9), .accentColor.opacity(0.9)], startPoint: .bottomLeading, endPoint: .topTrailing)
                }
                
                if style == .secondary {
                    Rectangle().fill(.ultraThinMaterial)
                }
                
                HStack(spacing: 10) {
                    if let icon {
                        Image(systemName: icon)
                            .imageScale(.medium)
                    }
                    
                    Text(title)
                        .font(.custom("LondrinaSolid-Light", size: 18))
                }
                .padding()
                .font(.headline)
    
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: .primary.opacity(0.3), radius: 3, x: 0, y: isTapped ? 0 : 5)
            .shadow(color: .primary.opacity(0.5), radius: 0, x: 0, y: isTapped ? 0 : 8)
            .padding(.top, isTapped ? 10 : 0)
        }
        .buttonStyle(.plain)
        .onHover { _ in
            withAnimation {
                isTapped.toggle()
            }
        }
    }
}
