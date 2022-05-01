//
//  persistence.swift
//  TryItOn
//
//  Created by snoopy on 13/04/2022.
//

import Foundation
import CoreData

class PersistenceController: ObservableObject {
    
    let container = NSPersistentContainer(name : "favouriteSneaker")
    
    init(){
        container.loadPersistentStores { description , error in
            if let error = error{
                print("core data fail to load \(error.localizedDescription)")
            }
        }
    }

    
}

