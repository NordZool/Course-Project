//
//  WordRow.swift
//  CourseProject
//
//  Created by admin on 2.12.23.
//

import SwiftUI

struct WordRow: View {
    @ObservedObject var word: Word
    
    var body: some View {
        HStack(spacing:0) {
            ScrollView(.horizontal) {
                
                HStack(spacing: 0) {
                    ForEach(WordFormsEnum.allCases, id:\.self) { wordFormType in
                        if let wordForm = word[wordFormType] {
                            VStack {
                               WordFormMark(as: wordFormType)
                                Text(wordForm)
                            }
                            .foregroundStyle(Functions.wordFormToColor(as: wordFormType))
                            .padding(.vertical)
                        }
                    }
                }
            }
            .padding(.leading, 20)
            .font(.title2)
            
            Button(role:.destructive) {
                //some destructive
            } label: {
                Image(systemName: "trash")
            }
            .offset(x:-10,y:-30)
            .font(.headline)
            
            Spacer()
            
        }
    }
}


//preview below
fileprivate struct Test : View {
    @ObservedObject var vm: WordsScreenViewModel = WordsScreenViewModel(managedObjectContext: Provider.shared.viewContext)
    var body: some View {
        WordRow(word: vm.wordsDictionary.first!.value.first!)
    }
}
#Preview {
    Test()
}
