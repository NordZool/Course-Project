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
                    Text(key.uppercased())
                        .padding(.leading, 10)
                        .font(.title)
                    
                    ForEach(values) {word in
                        WordRow(word: word)
                            .font(.title2)
                            .padding(.leading,40)
                        
                        
                        
                    }
                    
                }
                Spacer()
            }
        }
        
        
    }
}




fileprivate struct Test : View {
    @ObservedObject var vm: WordsScreenViewModel
    
    init() {
        self.vm = WordsScreenViewModel(managedObjectContext: Provider.shared.viewContext, searchString: "")
    }
    var body: some View {
        WordsList(viewModel: vm)
    }
}
#Preview {
    Test()
        .environment(\.managedObjectContext, Provider.shared.viewContext)
}
