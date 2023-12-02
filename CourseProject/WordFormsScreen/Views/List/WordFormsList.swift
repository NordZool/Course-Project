//
//  WordFormsList.swift
//  Course
//
//  Created by admin on 22.11.23.
//

import SwiftUI
import CoreData

struct WordFormsList: View {
    @ObservedObject var createFieldViewModel:CreateFieldViewModel
    @ObservedObject var wordFormsViewModel: WordFormViewModel
    
    private var managedObjectContext: NSManagedObjectContext
    
    //only for WordFormRow and ViewModels
    private let wordFormType: WordFormsEnum
    
    init(provider: Provider, wordFormType:WordFormsEnum) {
        let newContext = provider.newContext
        
        self.managedObjectContext = newContext
        self.createFieldViewModel = CreateFieldViewModel(context: newContext, wordFormType: wordFormType)
        self.wordFormsViewModel = WordFormViewModel(managedObjectContext: newContext, typeWordForm: wordFormType)
        
        self.wordFormType = wordFormType
    }
    
    var body: some View {
        
        ScrollView {
            WordFormCreateField(viewModel: createFieldViewModel)
                .padding(.top,10)
            ForEach(wordFormsViewModel.wordForms.sorted(by: {$0.key < $1.key}), id: \.key) {key, wordForms in

                VStack(alignment:.leading,spacing:30) {
                    Text(key.uppercased())
                        .padding(.leading, 10)
                        .font(.title)
                        .padding(.bottom,-20)
                    
                    ForEach(wordForms.sorted(by: {$0.str < $1.str})) { wordForm in
                        WordFormRow(form: wordForm, context:managedObjectContext, wordFormType)
                            
                    }
                    
                    
                }
                .padding(.bottom,20)
            }
        }
        
    }
}

#Preview {
    WordFormsList(provider: .shared, wordFormType: .pref)
        .environment(\.managedObjectContext, Provider.shared.viewContext)
}
