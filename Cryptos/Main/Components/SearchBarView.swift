//
//  SearchBarView.swift
//  SearchBarView
//
//  Created by Sergio Cardoso on 24/08/21.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.theme.secondaryText)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .padding()
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                        .offset(x: 10)
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.20), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
           
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
        }
        
    }
}
