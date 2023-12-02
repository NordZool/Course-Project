//
//  WordsScreenViewModel.swift
//  CourseProject
//
//  Created by admin on 2.12.23.
//

import Foundation
import CoreData

class WordsScreenViewModel : NSObject, NSFetchedResultsControllerDelegate ,ObservableObject, Identifiable {
    private let wordsController: NSFetchedResultsController<Word>
    
    init(managedObjectContext: NSManagedObjectContext) {
        //если допустим у слова не будет префикса, оно его не достанет что-ли?
        let sortDescriptor = [NSSortDescriptor(keyPath: \Word.prefix, ascending: false)]
        //трайнуть пустой
        wordsController = Word.resultsController(context: managedObjectContext, sortDescriptors: sortDescriptor)
        
        super.init()
        wordsController.delegate = self
        try? wordsController.performFetch()
    }
    //mb useless
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    var wordsDictionary: [String:[Word]] {
        //проверить в вью и сохранить при успехе на git
        Functions.alphabet(words: wordsController.fetchedObjects)
    }
    
}
