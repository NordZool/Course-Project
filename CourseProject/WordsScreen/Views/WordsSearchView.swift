//
//  WordsSearchView.swift
//  CourseProject
//
//  Created by admin on 5.12.23.
//

import SwiftUI

struct WordsSearchView: View {
    @Binding var searchText: String
    
    @FocusState private var searchIsFocused
    private let animation: Animation = .easeIn(duration: 0.3)
    var body: some View {
        HStack {
            Button {
                if !searchIsFocused {
                    searchIsFocused = true
                } else {
                    searchText = ""
                    searchIsFocused = false
                }
            } label: {
                ZStack {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(searchIsFocused ? .red : .black)
                        .scaleEffect(searchIsFocused ? 0 : 1)
                        .animation(animation, value: searchIsFocused)
                    Image(systemName: "multiply.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(searchIsFocused ? .red : .black)
                        .scaleEffect(searchIsFocused ? 1 : 0)
                        .animation(animation, value: searchIsFocused)
                }
                .frame(height: 25)
                
            }
            
            
            
            
            Capsule()
                .frame(width: 2,height: 25)
            TextField("Поиск...", text: $searchText)
                .frame(height: 40)
                .focused($searchIsFocused)
        }
        .padding(.horizontal,10)
        .background(
            Capsule()
                .foregroundStyle(.gray.opacity(0.2))
                .padding(.horizontal,6)
        )
    }
}


fileprivate struct Test : View {
    @State private var test = ""
    var body: some View {
        WordsSearchView(searchText: $test)
    }
}
#Preview {
    Test()
}
