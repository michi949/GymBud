//
//  Execution+CoreDataClass.swift
//  GymBud
//
//  Created by Reder on 22.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Execution)
public class Execution: NSManagedObject {
    convenience init(insertInto context: NSManagedObjectContext?){
        self.init(context: context!)
    }
}
