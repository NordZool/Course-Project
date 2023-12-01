//
//  CreateScreenViewModel.swift
//  Course
//
//  Created by admin on 21.11.23.
//

import Foundation
import CoreData

class CreateScreenViewModel : ObservableObject {
    @Published var word: Word
    
    private let context: NSManagedObjectContext
    
    init(provider: Provider) {
        self.context = provider.newContext
        self.word = Word(context:context)
    }
    
    func createWord() {
        self.save()
        word = Word(context: context)
    }
    
    func save()  {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
