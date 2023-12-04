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
        
      WordsList(viewModel: viewModel)
    }
}

#Preview {
    WordsScreen(viewModel: .init(managedObjectContext: Provider.shared.viewContext))
}
