//
//  CustomTabBarView.swift
//  Read Us
//
//  Created by Kuba Milcarz on 9/25/22.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    @State private var localSelection: TabBarItem
    
    init(tabs: [TabBarItem], selection: Binding<TabBarItem>) {
        self.tabs = tabs
        self._selection = selection
        self._localSelection = State(wrappedValue: selection.wrappedValue)
    }
    
    var body: some View {
        tabBarVersion2
            .onChange(of: selection) { value in
                withAnimation(.easeInOut(duration: 0.2)) {
                    localSelection = value
                }
            }
    }
}

extension CustomTabBarView {
    
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
    
    private func tabView2(tab: TabBarItem) -> some View {
        HStack(spacing: 10) {
            Image(systemName: tab.iconName)
                .font(.subheadline)
                .imageScale(.medium)
            Text(tab.title)
                .font(.custom("LondrinaSolid-Light", size: 14))
        }
        .foregroundColor(localSelection == tab ? tab.color : .gray)
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.background)
                        .shadow(color: .black.opacity(0.3), radius: 0, y: 3)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(tab.color.opacity(0.2))
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.accentColor.opacity(0.001))
                        .shadow(color: .black.opacity(0.001), radius: 0, y: 3)
                    
                    Color.accentColor.opacity(0.001)
                }
            }
        )
    }
    
    private var tabBarVersion2: some View {
        ZStack {
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    tabView2(tab: tab)
                        .onTapGesture {
                            switchToTab(tab: tab)
                        }
                }
            }
            .padding(6)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18))
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 20)
        }
    }
    
}
