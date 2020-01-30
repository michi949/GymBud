//
//  CoreDataManager.swift
//  GymBud
//
//  Created by Reder on 21.01.20.
//  Copyright © 2020 Reder. All rights reserved.
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
            _ = Exercise(name: "Squats", description: "A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.", image: UIImage(named: "squats"), insertInto: self.getContext(context: .parent))
            _ = Exercise(name: "Treadmill", description: "Improve your strength in running and train your heart. Frequently running is good for you.", image: UIImage(named: "treadmille"), insertInto: self.getContext(context: .parent))
            _ = Exercise(name: "Stepper", description: "The stepper is good for your ass! Walk a few steps and you will feel it in your ass.", image: UIImage(named: "fitness-women-sports-gym"), insertInto: self.getContext(context: .parent))
            _ = Exercise(name: "Deadlifts", description: "Deadlifts are a high intensive exercise for all parts of your body.", image: UIImage(named: "dealifts"), insertInto: self.getContext(context: .parent))
            _ = Exercise(name: "Abs", description: "Abs are mostly attractive to girls so start doing this!", image: UIImage(named: "abs"), insertInto: self.getContext(context: .parent))
            UserPrefernces.setHasLoadedExercises(hasLoaded: true)
            saveAllContext()
        }
    }
}
