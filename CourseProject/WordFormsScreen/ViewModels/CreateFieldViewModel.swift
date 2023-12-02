//
//  WordFormsViewModel.swift
//  Course
//
//  Created by admin on 25.11.23.
//

import Foundation
import CoreData


class CreateFieldViewModel : ObservableObject {
    
    private let context: NSManagedObjectContext
    private var wordFormType: WordFormsEnum
    
    init(context:NSManagedObjectContext,wordFormType: WordFormsEnum) {
        self.context = context
        self.wordFormType = wordFormType
    }
    
    func createWordForm(from text:String) {
        //переопределяю text
        let text = Functions.correct(str: text, as: wordFormType)
        
        //если такой словоформы еще нету
        if !(Functions.contains(str: text, in: wordFormType, context)) {
            let newWordForm: WordForm
            
            switch wordFormType {
            case .pref:
                newWordForm = Prefix(context: context)
            case .rt:
                newWordForm = Root(context: context)
            case .suf:
                newWordForm = Suffix(context: context)
            case .postf:
                newWordForm = Postfix(context: context)
            }
            newWordForm.str = text
            
            self.save()
        }
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
