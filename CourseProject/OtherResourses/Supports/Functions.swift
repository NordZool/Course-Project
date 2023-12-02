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
    
    //словарь для составления списка
    //слов по алфавиту
    static func alphabet(words: [Word]?) -> [String:[Word]] {
        var dictionary: [String:[Word]] = [:]
        if let words = words {
            for word in words {
                let fullWord = word.getFullWord() ?? ""
                if !fullWord.isEmpty {
                    dictionary[String(fullWord[fullWord.startIndex]),default: []] += [word]
                } else {
                    dictionary["empty", default: []] += [word]
                }
            }
        }
        
        return dictionary
    }
    
    //Проверяет, существует ли словоформа,
    //равная переданной строке.
    //испольщуется для исбежания добавления
    //дубликатов словоформ в CreateFieldViewModel и WordFormRow
    static func contains(str:String, in form: WordFormsEnum,_ context:NSManagedObjectContext) -> Bool {
        ((try? (context.fetch(Functions.fetchRequest(as: form)) as? [WordForm])) ?? []).contains(where: {$0.str == str})
    }
    
    //преобразует введенный пользователем текст в
    //корректный для словоформ.
    //Ипользуется в CreateFieldViewModel и WordFormRow
    static func correct(str: String, as form:WordFormsEnum) -> String {
        let sumbolsForDelete =  " .,;:'/|[]{}!?@#$%^&*()_-+=><"
        //удаляем бессмысленные символы
        var text:String = str.filter({!sumbolsForDelete.contains($0)})
        
        text = text.lowercased()
        if form == .pref {
            //делаем первую букву заглавной
            //т.к приставка - начало слова
            text = ((text.first?.uppercased() ?? "") + text.dropFirst(1))
        }
        
        return text
    }
    
    
}
