//
//  WordFormsScreen.swift
//  Course
//
//  Created by admin on 22.11.23.
//

import SwiftUI

struct WordFormsScreen: View {
    @State private var wordFormNow: WordFormsEnum = .pref
    var provider:Provider
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $wordFormNow) {
                ForEach(WordFormsEnum.allCases, id: \.self) {wordForm in
                    
                    WordFormsList(
                        provider: provider,
                        wordFormType: wordForm
                    )
                    .padding(.vertical,27)
                    .padding(.top,13)
                    .tag(wordForm)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            CustomTabView(wordFormNow: $wordFormNow)
            BackButton()
            VStack {
                Text("Словоформы")
                    .font(.title2)
                    .fontWeight(.semibold)
                Divider()
            }
        }
    }
}

#Preview {
    WordFormsScreen(provider: Provider.shared)
}
