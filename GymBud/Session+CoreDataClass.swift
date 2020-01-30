//
//  Session+CoreDataClass.swift
//  GymBud
//
//  Created by Reder on 22.01.20.
//  Copyright © 2020 Reder. All rights reserved.
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
