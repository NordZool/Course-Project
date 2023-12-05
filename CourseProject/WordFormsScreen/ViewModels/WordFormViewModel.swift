//
//  WordFormViewModel.swift
//  Course
//
//  Created by admin on 28.11.23.
//

import Foundation
import CoreData

class WordFormViewModel : NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
    private let wordsFormController: NSFetchedResultsController<WordForm>
    
    init(managedObjectContext: NSManagedObjectContext, typeWordForm: WordFormsEnum) {
        let sortDescriptor = [NSSortDescriptor(keyPath: \WordForm.str, ascending: false)]
        wordsFormController = WordForm.resultsController(context: managedObjectContext, typeWordForm, sortDescriptors: sortDescriptor)
        
        super.init()
        wordsFormController.delegate = self
        try? wordsFormController.performFetch()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    var wordForms: [String:[WordForm]] {
        Functions.alphabet(forms: wordsFormController.fetchedObjects)
    }
}
