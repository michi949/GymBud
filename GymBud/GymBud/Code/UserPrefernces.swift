//
//  UserPrefernces.swift
//  GymBud
//
//  Created by Reder on 20.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import Foundation

class UserPrefernces {
    static let defaults = UserDefaults.standard
    
    ///User properties
    static let NAME = "NAME"
    static let AGE = "AGE"
    static let WEIGHT = "WEIGHT"
    static let HEIGHT = "HEIGHT"
    static let LATOFGYM = "LATOFGYM"
    static let LONGOFGYM = "LONGOFGYM"
    static let ISLOGGEDIN = "ISLOGGEDIN"
    static let GYMNAME = "GYMNAME"
    
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
    
    public static func setPositionOfGym(lat: Double, long: Double, gymName: String){
        defaults.set(lat, forKey: LATOFGYM)
        defaults.set(long, forKey: LONGOFGYM)
        defaults.set(gymName, forKey: GYMNAME)
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
    
    public static func getPositionOfGym() -> (lat: Double, long: Double, gymName: String){
        let long = defaults.double(forKey: LONGOFGYM)
        let lat = defaults.double(forKey: LATOFGYM)
        let gymName = defaults.string(forKey: GYMNAME)
        return (lat: lat, long: long, gymName: gymName ?? "")
    }
}

