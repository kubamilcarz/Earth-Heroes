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
    
    init(_ title: LocalizedStringKey) {
        self.title = title
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
                Spacer()
                
                Button {
                    appVM.changePage(to: nil)
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
