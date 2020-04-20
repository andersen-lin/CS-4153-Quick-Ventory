//
//  Item.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/20/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import Foundation
import CoreData

public class Item:NSManagedObject, Identifiable {
    @NSManaged public var category:String?
    @NSManaged public var category_image_name:String?
}
