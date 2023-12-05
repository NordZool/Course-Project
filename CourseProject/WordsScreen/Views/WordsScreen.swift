//
//  WordScreen.swift
//  CourseProject
//
//  Created by admin on 2.12.23.
//

import SwiftUI

struct WordsScreen: View {
    @State private var search = ""
    
    var provider: Provider
    
    var body: some View {
        ZStack {
            VStack {
                Text("Слова")
                    .font(.title)
                    .fontWeight(.semibold)
                WordsSearchView(searchText: $search)
                Divider()
                    .offset(y:7)
                WordsList(viewModel: WordsScreenViewModel(managedObjectContext: provider.viewContext, searchString: search))
            }
            BackButton()
        }
    }
}

#Preview {
    WordsScreen( provider: Provider.shared)
}
