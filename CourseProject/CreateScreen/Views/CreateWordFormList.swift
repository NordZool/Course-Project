//
//  CreateWordFormList.swift
//  Course work
//
//  Created by admin on 4.11.23.
//

import SwiftUI
import CoreData

struct CreateWordFormList: View {
    let typeWordForm: WordFormsEnum
    @Binding var wordFormNow: WordFormsEnum
    @Binding var word: Word
    
    private let wordFormsDictionary: [String:[WordForm]]
    
    init(typeWordForm: WordFormsEnum, wordFormNow: Binding<WordFormsEnum>,word:Binding<Word>, context: NSManagedObjectContext) {
        self.typeWordForm = typeWordForm
        self._word = word //binding
        self._wordFormNow = wordFormNow //binding
        
        //try get data
        let wordForms = try? context.fetch(Functions.fetchRequest(as: typeWordForm)) as? [WordForm]
        wordFormsDictionary = Functions.alphabet(forms: wordForms)
    }
    
    var body: some View {
        ScrollView {
            ForEach(Array(wordFormsDictionary.keys).sorted(by: <), id: \.self) { wordFormKey in
                
                VStack(alignment:.leading,spacing: 15) {
                    Text(wordFormKey.uppercased())
                        .padding(.leading, 10)
                        .font(.title)
                    
                    ForEach(wordFormsDictionary[wordFormKey]!.sorted(by: {$0.str < $1.str})) { wordForm in
                        HStack {
                            Button {
                                if word[typeWordForm] != wordForm.str {
                                    word[typeWordForm] = wordForm.str
                                    
                                    //инициализирую самого себя чтобы
                                    //все view использующие
                                    //word обновились сразу
                                    word = word
                                    
                                    //перехожу на след список
                                    withAnimation(.linear(duration: 0.3)) {
                                        wordFormNow = wordFormNow.next
                                    }
                                } else {
                                    //нажав на туже словоформу
                                    //она очистится
                                    word[typeWordForm] = nil
                                    
                                    //инициализирую самого себя
                                    word = word
                                }
                                
                                
                                
                            } label: {
                                Text(wordForm.str)
                                    .foregroundColor(.black)
                                    .padding(5)
                                    .background(
                                        Capsule()
                                            .foregroundStyle(Color.gray.opacity(0.2))
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(.black, lineWidth: 1)
                                    )
                                    .font(.title2)
                            }
                            .padding(.leading,20)
                            Spacer()
                            
                            
                        }
                    }
                    
                }
                .padding(.bottom,20)
            }
        }
        
    }
}

fileprivate struct Test : View {
    @StateObject private var viewModel = CreateScreenViewModel(provider: .shared)
    @Environment (\.managedObjectContext) private var moc
    @State private var wordFormNow: WordFormsEnum = .pref
    var body: some View {
        VStack {
            CreateWordFormList(typeWordForm: .pref, wordFormNow: $wordFormNow, word: $viewModel.word,context: moc)
            
            //            Text("For test")
            //
            
        }
    }
}

struct CreateWordFormList_Previews: PreviewProvider {
    
    static var previews: some View {
        Test()
            .environment(\.managedObjectContext, Provider.shared.viewContext)
        
    }
}
