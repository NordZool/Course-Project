//
//  WordScreen.swift
//  CourseProject
//
//  Created by admin on 2.12.23.
//

import SwiftUI

struct WordsScreen: View {
    @ObservedObject var viewModel: WordsScreenViewModel
    
    var body: some View {
        List(viewModel.wordsDictionary.sorted(by: {$0.key < $1.key}), id: \.key) {key, values in
            Text(key)
                .font(.title)
            ForEach(values) {word in
                Text(word.getFullWord() ?? "  ")
            }
        }
    }
}

#Preview {
    WordsScreen(viewModel: .init(managedObjectContext: Provider.shared.viewContext))
}
