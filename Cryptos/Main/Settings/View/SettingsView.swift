//
//  SettingsView.swift
//  SettingsView
//
//  Created by Sergio Cardoso on 08/09/21.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                List {
                    Section(header: Text("Swiftful Thinking")) {
                        VStack(alignment: .leading) {
                            Image("logo")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            Text("This app was created following a Swiftul Thinking course on YouTube")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(Color.theme.accent)
                                .multilineTextAlignment(.leading)
                        }.padding(.vertical)
                            
                    }.listRowBackground(Color.theme.background.opacity(0.5))
                    Section {
                        VStack(alignment: .leading){
                            Image("coingecko")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            Text("The cryptocurrency data that is used in this app comes from a free API from coinGecko! Prices may be slightly delayed.")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(Color.theme.accent)
                        }
                        .padding(.vertical)
                        
                        Link("Visit coinGecko 🥳", destination: coingeckoURL)
                    } header: {
                        Text("Coingeck")
                    }.listRowBackground(Color.theme.background.opacity(0.5))
                    Section {
                        VStack(alignment: .leading){
                            Image("myself")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            Text("This app was developed by Sergio Aquiles. It uses SwiftUI and is written 100% in Swift.")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(Color.theme.accent)
                        }
                        .padding(.vertical)
                    } header: {
                        Text("Developer")
                    }.listRowBackground(Color.theme.background.opacity(0.5))
                    
                }
                .accentColor(.blue)
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        }
                    }
            }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
