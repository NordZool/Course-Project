//
//  WordFormViewModel.swift
//  Course
//
//  Created by admin on 28.11.23.
//

import Foundation
import CoreData

class WordFormViewModel : NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
    private let wordFormController: NSFetchedResultsController<WordForm>
    
    init(managedObjectContext: NSManagedObjectContext, typeWordForm: WordFormsEnum) {
        let sortDescriptor = [NSSortDescriptor(keyPath: \WordForm.str, ascending: true)]
        wordFormController = WordForm.resultsController(context: managedObjectContext, typeWordForm, sortDescriptors: sortDescriptor)
        
        super.init()
        wordFormController.delegate = self
        try? wordFormController.performFetch()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
//    var wordForms: [WordForm] {
//        wordFormController.fetchedObjects ?? []
//    }
    
    var wordForms: [String:[WordForm]] {
        Functions.alphabet(forms: wordFormController.fetchedObjects)
    }
}
