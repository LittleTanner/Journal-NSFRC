//
//  EntryController.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedInstance = EntryController()
    
    /// Entries is a computed Property. Its getting its values from the results of a NSFetchRequest. The <Model> means defines the generic type. This ensures that our entries array can ONLY hold Entry Objects.
    var entries: [Entry] {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    //CRUD
    /// We define a createEntry method that takes in two strings: Title, and body.
    func createEntry(withTitle: String, withBody: String) {
        // Then we are using the convenience init we extended the Entry Class with and pass in those strings. This creates our Entry Objects with all required data.
        let _ = Entry(title: withTitle, body: withBody)
        
        saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        
        saveToPersistentStore()
    }
    
    /// Removing Entry from persistent store
    func deleteEntry(entry: Entry) {
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStore()
    }
    
    /// We are 'attempting' to save all our Entry Data to our CoreDataStack(s) Persistent Store
    func saveToPersistentStore() {
        do {
             try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object. Items not saved!! \(#function) : \(error.localizedDescription)")
        }
    }
}
