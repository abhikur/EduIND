//
//  Student+CoreDataProperties.swift
//  EduIND
//
//  Created by Abhishet on 11/05/2016.
//  Copyright © 2016 Abhishet. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Student {

    @NSManaged var name: String?
    @NSManaged var age: String?
    @NSManaged var city: String?
    @NSManaged var state: String?
    @NSManaged var country: String?
    @NSManaged var image: NSData?
    @NSManaged var desc: String?

}
