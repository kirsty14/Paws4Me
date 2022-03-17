//
//  PetName+CoreDataProperties.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/11.
//
//

import Foundation
import CoreData

extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var petImage: String?
    @NSManaged public var petName: String?

}
