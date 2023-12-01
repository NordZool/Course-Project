//
//  Functions.swift
//  Course
//
//  Created by admin on 21.11.23.
//

import Foundation
import CoreData

//singleton struct
struct Functions {
    
    //запрос для чтения, изменения и удаления
    //словоформ разного типа
    static func fetchRequest(as form: WordFormsEnum) -> NSFetchRequest<NSFetchRequestResult> {
        switch form {
        case .pref:
            Prefix.fetchRequest()
        case .rt:
            Root.fetchRequest()
        case .suf:
            Suffix.fetchRequest()
        case .postf:
            Postfix.fetchRequest()
        }
    }
    
    //словарь для составления списка
    //словоформ по алфавиту
    static func alphabet(forms: [WordForm]?) -> [String:[WordForm]] {
        var dictionary: [String:[WordForm]] = [:]
        if let forms = forms {
            for form in forms {
                if !form.str.isEmpty {
                    dictionary[String(form.str[form.str.startIndex]),default: []] += [form]
                } else {
                    dictionary["empty", default: []] += [form]
                }
            }
        }
        
        return dictionary
    }
    
    
}
