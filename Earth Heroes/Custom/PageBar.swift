//
//  PageBar.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct PageBar: View {
    @EnvironmentObject var appVM: AppViewModel
    var title: LocalizedStringKey
    var action: () -> Void
    var hasCustomAction: Bool
    var isFunFact: Bool
    
    init(_ title: LocalizedStringKey, isFunFact: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.hasCustomAction = true
        self.isFunFact = isFunFact
    }
    
    init(_ title: LocalizedStringKey, isFunFact: Bool = false) {
        self.title = title
        self.action = { }
        self.hasCustomAction = false
        self.isFunFact = isFunFact
    }
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                Text(title)
                    .heroTitle()
                
                Spacer()
            }
            
            HStack {
                if isFunFact {
                    Image(systemName: "sparkles")
                        .foregroundColor(.yellow)
                        .font(.title3)
                }
                
                Spacer()
                
                Button {
                    if hasCustomAction {
                        action()
                    } else {
                        appVM.changePage(to: nil)
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.subheadline)
                        .padding(10)
                        .frame(width: 30, height: 30)
                        .background(.ultraThinMaterial, in: Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, y: 4)
                }
            }
        }
        .padding()
    }
}
