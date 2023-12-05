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
        
        //Доделать TextField 
        //добавить title "Слова"
        //добавить кнопку "Back"
        //добавить Divider
        TextField("Найти слово", text: $search)
        WordsList(viewModel: WordsScreenViewModel(managedObjectContext: provider.viewContext, searchString: search))
    }
}

#Preview {
    WordsScreen( provider: Provider.shared)
}
