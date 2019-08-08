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
    
    // Local NSFRC var
    var fetchedResultsController: NSFetchedResultsController<Entry>
    
    // NSFRC:
    init() {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Assign the NSFRC we just created to the local var so we can access the resultsController outside of this init
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch!!! \(#function) \(error.localizedDescription)")
        }
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
