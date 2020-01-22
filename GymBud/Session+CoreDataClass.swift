//
//  Session+CoreDataClass.swift
//  GymBud
//
//  Created by itsedev on 22.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Session)
public class Session: NSManagedObject {
    convenience init(insertInto context: NSManagedObjectContext?){
        self.init(context: context!)
    }
}
