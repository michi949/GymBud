//
//  CaloriesCalculator.swift
//  GymBud
//
//  Created by Daniela Steinöcker on 27.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import Foundation

class CaloriesCalculator {
    var heartBeat:Int!
    var healthUpdater:HealthUpdater!
    var timer:Timer!
    var counter:Int!
    var hours:Float!
    var totalCalories:Float = 0.0
    var totalInt:Int!
    var weight = 70
    var age = 22
    
    init(healthUpdater: HealthUpdater) {
        self.healthUpdater = healthUpdater
        heartBeat = Int.random(in: 50 ..< 180)
        counter = 0
    }
    
    func start(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stop(){
        timer.invalidate()
        counter = 0
    }
    
    func sendHeartRate(heartRate:Int){
        self.heartBeat = heartRate
    }
    
    func calculate(){
        incrementTimer()
        // ((-55.0969 + (0.6309 * heartBeat) + (0.1988 * weight) + (0.2017 * age))/4.184)
        let calc:Float = ((-55.0969 + (0.6309 * Float(heartBeat)) + (0.1988 * Float(weight)) + (0.2017 * Float(age)))/4.184) * 60.0 * Float(hours) * 1 / 3600
        //let final = calc * 60 * counter
        self.totalCalories = totalCalories + calc
        self.totalInt = Int(floor(totalCalories))
    }
    
    @objc func update(){
        calculate()
        healthUpdater.updatekCal(kCalCounter: self.totalInt)
    }
    
    func incrementTimer(){
        counter += 1
        hours = Float(counter) / 60
    }
    
    
}
