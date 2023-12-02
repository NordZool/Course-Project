//
//  Word.swift
//  Course work
//
//  Created by admin on 7.11.23.
//

import Foundation
import CoreData

class Word : NSManagedObject, Identifiable {
    @NSManaged var prefix: String?
    @NSManaged var root: String?
    @NSManaged var suffix: String?
    @NSManaged var postfix: String?
    
    func getFullWord() -> String? {
        let word = [prefix,root,suffix,postfix].compactMap({$0})
        //если слово пустое - вернуть nil, иначе вернуть слово
        return word.isEmpty ? nil : word.reduce("", +)
    }
    func clear() {
        prefix = nil
        root = nil
        suffix = nil
        postfix = nil
    }
    
    //аналог перегрузки оператор "[]" в C++
    subscript (wordFormType: WordFormsEnum) -> String? {
        get {
            switch wordFormType {
            case .pref:
                prefix
            case .rt:
                root
            case .suf:
                suffix
            case .postf:
                postfix
            }
        }
        set {
            switch wordFormType {
            case .pref:
                prefix = newValue
            case .rt:
                root = newValue
            case .suf:
                suffix = newValue
            case .postf:
                postfix = newValue
            }
        }
    }
    
    //Запрашивает и возвращает данные для WordsScreenViewModel
    static func resultsController(context: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor] = []) -> NSFetchedResultsController<Word> {
        let request = NSFetchRequest<Word>(entityName: "Word")
        request.sortDescriptors = sortDescriptors.isEmpty ? nil : sortDescriptors
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
}
