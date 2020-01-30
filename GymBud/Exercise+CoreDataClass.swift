//
//  Exercise+CoreDataClass.swift
//  GymBud
//
//  Created by Reder on 22.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//
//

import Foundation
import AVKit
import CoreData

@objc(Exercise)
public class Exercise: NSManagedObject {
    convenience init(name: String?, description: String?, image: UIImage?, insertInto context: NSManagedObjectContext?){
        self.init(context: context!)
        
        self.name = name ?? "Squats"
        self.descriptionText = description ?? "No description"
        self.image = image?.pngData()
    }
}
