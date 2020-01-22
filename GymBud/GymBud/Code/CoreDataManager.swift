//
//  CoreDataManager.swift
//  GymBud
//
//  Created by itsedev on 21.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//

import Foundation
import CoreData
import AVKit

class CoreDataManager{
    private let appDelegate:AppDelegate!
    private let childContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    enum ContextTyp{
        case child
        case parent
    }
    
    /// - Value parentContext: Get the information from the current container the application is running
    init(delegate:AppDelegate){
        appDelegate = delegate
        childContext.parent = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: Context
    func getContext(context: ContextTyp) -> NSManagedObjectContext{
        if context == .child {
            return childContext
        } else {
            return childContext.parent!
        }
    }
    
    /// Saves the current context, first child and then the parrent.
    /// To work with async tasks we use handler to perform the save.
    ///   - Throws: Core Data 'error' with information aborut current context.
    func saveAllContext(){
        childContext.perform{
            do {
                try self.childContext.save()
                self.childContext.parent?.performAndWait {
                    do {
                        try self.childContext.parent?.save()
                        self.appDelegate.saveContext()
                    } catch {
                        print("No save possible.")
                    }
                }
            } catch {
                print("No save possible.")
            }
        }
    }
    
    //MARK: Exercises
    func fetchAllExercises(context: ContextTyp) -> [Exercise] {
        var exercises: [Exercise] = []
        let req = NSFetchRequest<Exercise>(entityName: "Exercise")
        
        do {
            if context == .child {
                exercises = try (childContext.fetch(req))
            } else {
                exercises = try (childContext.parent!.fetch(req))
            }
        } catch {
            print("Not able to load data from Core Data!")
        }
        return exercises
    }
    
    func initAllExercises(){
        if !UserPrefernces.hasLoadedExercises() {
            _ = Exercise(name: "Squats", description: "", image: UIImage(), insertInto: self.getContext(context: .child))
            _ = Exercise(name: "Treadmile", description: "", image: UIImage(), insertInto: self.getContext(context: .child))
            _ = Exercise(name: "Stepper", description: "", image: UIImage(), insertInto: self.getContext(context: .child))
            _ = Exercise(name: "Deadlifts", description: "", image: UIImage(), insertInto: self.getContext(context: .child))
            _ = Exercise(name: "Six Pack", description: "", image: UIImage(), insertInto: self.getContext(context: .child))
            saveAllContext()
        }
    }
}
