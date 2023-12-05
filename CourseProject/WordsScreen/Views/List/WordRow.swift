//
//  WordRow.swift
//  CourseProject
//
//  Created by admin on 2.12.23.
//

import SwiftUI
import CoreData

struct WordRow: View {
    @ObservedObject var word: Word
    @Environment(\.managedObjectContext) private var managedObjectContext: NSManagedObjectContext
    
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
            .padding(.trailing,10)
            .font(.title2)
            
            Button(role:.destructive) {
                managedObjectContext.delete(word)
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
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
    var body: some View {
        WordRow(word: WordsScreenViewModel(managedObjectContext: Provider.shared.viewContext, searchString: "").wordsDictionary.first!.value.first!)
    }
}
#Preview {
    Test()
        .environment(\.managedObjectContext, Provider.shared.viewContext)
}
