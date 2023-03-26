//
//  CreditsView.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/26/23.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()

            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            
            ScrollView {
                VStack(spacing: 70) {
                    VStack(spacing: 30) {
                        Text("Our Team")
                            .font(.custom(HeroFont.regular.rawValue, size: 26))
                        
                        VStack(spacing: 30) {
                            person(name: "Nikoletta Solarz-Kustov", title: "CEO", role: "Managing Director")
                            
                            person(name: "Jakub Milcarz", title: "CTO", role: "Lead Developer")
                            
                            person(name: "Marceli Bachta", title: "COO", role: "Head of Business Operations")
                            
                            person(name: "Aleksander Sternicki", title: "VP of Engineering", role: "Co-Developer")
                            
                            person(name: "Robert Marcinkiewicz", title: "CFO", role: "Financial Director")
                            
                            person(name: "Natalia Rudko", title: "Co-Founder")
                            
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    VStack(spacing: 30) {
                        Text("Credits")
                            .font(.custom(HeroFont.regular.rawValue, size: 26))
                        
                        VStack(spacing: 15) {
                            Link("Graphics from Freepik.com", destination: URL(string: "https://www.freepik.com")!)
                            
                            Link("Privacy Policy", destination: URL(string: "https://www.craft.do/s/4blUzu4rimMo7p")!)
                                
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                }
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .padding()
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
        .preferredColorScheme(.light)
    }
    
    private func person(name: String, title: LocalizedStringKey, role: LocalizedStringKey? = nil) -> some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom(HeroFont.light.rawValue, size: 20))
                    .foregroundStyle(.primary)
                if let role {
                    Text(role)
                        .font(.custom(HeroFont.light.rawValue, size: 15))
                }
            }
            Spacer()
            Text(name)
                .font(.custom(HeroFont.light.rawValue, size: 20))
        }
        .foregroundStyle(.primary.opacity(0.7))
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
