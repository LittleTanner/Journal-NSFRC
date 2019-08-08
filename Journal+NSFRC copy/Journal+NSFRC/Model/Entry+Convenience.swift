//
//  Entry+Convenience.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    /// Delcare our convenience init. We are adding a default value for our MOC and Date. We call the memberwise init of Entry and init with our context.
    convenience init(title: String, body: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.context) {
        // For memberwise
        self.init(context: context)
        // For convenience
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}
