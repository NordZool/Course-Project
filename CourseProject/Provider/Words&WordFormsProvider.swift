//
//  Words&WordFormsProvider.swift
//  Course work
//
//  Created by admin on 16.11.23.
//

import Foundation
import CoreData

final class Provider {
    static let shared = Provider()
    
    private let presistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        presistentContainer.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        presistentContainer.newBackgroundContext() //рано сделал, пока не юзал
    }
    
    private init() {
        //назначаем откуда берем данные
        presistentContainer = NSPersistentContainer(name: "DataModel")
        presistentContainer.viewContext.automaticallyMergesChangesFromParent = true //понять точнее зачем эта строчка
        //подкачка данных
        presistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print(error)
            }
        }
    }
}
