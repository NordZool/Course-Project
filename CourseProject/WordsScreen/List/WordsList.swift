//
//  WordsScreenList.swift
//  CourseProject
//
//  Created by admin on 2.12.23.
//

import SwiftUI

struct WordsList: View {
    @ObservedObject var viewModel: WordsScreenViewModel
    var body: some View {
        ScrollView {
            VStack(alignment:.leading) {
                
                ForEach(viewModel.wordsDictionary.sorted(by: {$0.key < $1.key}), id: \.key) {key, values in
                    Text(key)
                        .padding(.leading, 10)
                        .font(.title)
                    ForEach(values) {word in
                            WordRow(word: word)
                                .font(.title2)
                        
                        
                    }
                    
                }
                Spacer()
            }
        }
    }
}


fileprivate struct Test : View {
    @ObservedObject var vm: WordsScreenViewModel = WordsScreenViewModel(managedObjectContext: Provider.shared.viewContext)
    var body: some View {
        WordsList(viewModel: vm)
    }
}
#Preview {
    Test()
}
