//
//  WordsScreenViewModel.swift
//  CourseProject
//
//  Created by admin on 2.12.23.
//


import CoreData
import SwiftUI

class WordsScreenViewModel : NSObject, NSFetchedResultsControllerDelegate ,ObservableObject, Identifiable {
    private let wordsController: NSFetchedResultsController<Word>
    let searchRequest: String
    
    init(managedObjectContext: NSManagedObjectContext, searchString:String) {
        self.searchRequest = searchString.lowercased()
        //без заполненого sortDescriptors крашит приложение
        let sortDescriptors = [NSSortDescriptor(keyPath: \Word.prefix, ascending: false)]
        //трайнуть пустой
        wordsController = Word.resultsController(context: managedObjectContext, sortDescriptors: sortDescriptors)
        
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
        let resoult = Functions.alphabet(words: wordsController.fetchedObjects)
        if let searchChar = searchRequest.first {
            var searchResult: [Word] = []
            
            resoult[String(searchChar)]?.forEach { word in
                if let wordInStr = word.getFullWord()?.lowercased() {
                    if wordInStr.count >= searchRequest.count {
                        if wordInStr.dropLast(wordInStr.count - searchRequest.count) == searchRequest {
                            searchResult.append(word)
                        }
                    }
                }
            }
            
            if searchResult.isEmpty {
                return [:]
            } else {
                return [String(searchChar):searchResult]
            }
        } else {
            return resoult
        }
    }
    
}
