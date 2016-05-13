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

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?

}
