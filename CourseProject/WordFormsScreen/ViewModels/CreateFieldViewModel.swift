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
        //если такой словоформы еще нету
        if !(try! context.fetch(Functions.fetchRequest(as: wordFormType)) as! [WordForm]).contains(where: {$0.str == text}) {
            let newWordForm: WordForm
            //делаю text изменьчивым
            var text = text
            
            switch wordFormType {
            case .pref:
                newWordForm = Prefix(context: context)
                text = text.lowercased()
                //делаем первую букву заглавной
                text = ((text.first?.uppercased() ?? "") + text.dropFirst(1))
            case .rt:
                newWordForm = Root(context: context)
                text = text.lowercased()
            case .suf:
                newWordForm = Suffix(context: context)
                text = text.lowercased()
            case .postf:
                newWordForm = Postfix(context: context)
                text = text.lowercased()
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
