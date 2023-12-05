//
//  WordForm.swift
//  Course work
//
//  Created by admin on 14.11.23.
//

import Foundation
import CoreData


class WordForm :  NSManagedObject, Identifiable {
    
    @NSManaged var str: String
    
    static func resultsController(context: NSManagedObjectContext,_ typeWordForm: WordFormsEnum , sortDescriptors: [NSSortDescriptor] = []) ->
    NSFetchedResultsController<WordForm> {
        
        let request:NSFetchRequest<WordForm>
        switch typeWordForm {
        case .pref:
            request = NSFetchRequest<WordForm>(entityName: "Prefix")
        case .rt:
            request = NSFetchRequest<WordForm>(entityName: "Root")
        case .suf:
            request = NSFetchRequest<WordForm>(entityName: "Suffix")
        case .postf:
            request = NSFetchRequest<WordForm>(entityName: "Postfix")
        }
        request.sortDescriptors = sortDescriptors.isEmpty ? nil : sortDescriptors
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
}

class Prefix : WordForm {}
class Root : WordForm {}
class Suffix : WordForm {}
class Postfix : WordForm {}
