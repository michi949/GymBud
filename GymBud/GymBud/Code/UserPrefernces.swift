//
//  UserPrefernces.swift
//  GymBud
//
//  Created by itsedev on 20.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//

import Foundation

class UserPrefernces {
    static let defaults = UserDefaults.standard
    
    ///User properties
    static let NAME = "NAME"
    static let AGE = "AGE"
    static let WEIGHT = "WEIGHT"
    static let HEIGHT = "HEIGHT"
    static let ISLOGGEDIN = "ISLOGGEDIN"
    
    //SetUps
    static let EXERCISES = "EXERCISES"
    
    // MARK: Setter
    public  static func setUser(name: String, age: Int, weight: Double, height: Double){
        defaults.set(name, forKey: NAME)
        defaults.set(age, forKey: AGE)
        defaults.set(weight, forKey: WEIGHT)
        defaults.set(height, forKey: HEIGHT)
    }
    
    public static func setName(name: String){
        defaults.set(name, forKey: NAME)
    }
    
    public static func setAge(age: Int){
         defaults.set(age, forKey: AGE)
    }
    
    public static func setWeight(weight: Double){
            defaults.set(weight, forKey: WEIGHT)
    }
    
    public static func setHeight(height: Double){
            defaults.set(height, forKey: HEIGHT)
    }
    
    public static func setLoggedIn(loggedIn: Bool){
        defaults.set(loggedIn, forKey: ISLOGGEDIN)
    }
    
    public static func setHasLoadedExercises(hasLoaded: Bool){
        defaults.set(hasLoaded, forKey: EXERCISES)
    }
    
    // MARK: Getter
    public static func getUser() -> (user: String, age: Int, weight: Double, height: Double) {
        let user = defaults.string(forKey: NAME) ?? ""
        let age = defaults.integer(forKey: AGE)
        let weight = defaults.double(forKey: WEIGHT)
        let height = defaults.double(forKey: HEIGHT)
        
        return (user, age, weight, height)
    }
    
    
    public static func getName() -> String {
        return defaults.string(forKey: NAME) ?? ""
    }
    
    public static func getAge() -> Int {
        return defaults.integer(forKey: AGE)
    }
    
    public static func getWeight() -> Double {
        return defaults.double(forKey: WEIGHT)
    }

    public static func getHeight() -> Double {
        return defaults.double(forKey: HEIGHT)
    }
    
    public static func isLoggedIn() -> Bool {
        return defaults.bool(forKey: ISLOGGEDIN)
    }
    
    public static func hasLoadedExercises() -> Bool {
        return defaults.bool(forKey: EXERCISES)
    }
}

