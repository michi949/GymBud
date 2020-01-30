//
//  HeartBeat.swift
//  GymBud
//
//  Created by Reder on 26.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import Foundation

class HeartBeatSensor{
    var heartBeat:Int!
    var healthUpdater:HealthUpdater!
    var timer:Timer!
    
    init(healthUpdater: HealthUpdater) {
        self.healthUpdater = healthUpdater
        heartBeat = Int.random(in: 130 ..< 180)
    }
    
    func start(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateHeartRate), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stop(){
        timer.invalidate()
    }
    
    func getRandomHeartBeat() -> Int{
        let maxHeart = heartBeat + 10
        let minHeart = heartBeat - 10
        
        if maxHeart > 180 {
            return Int.random(in: 160 ..< 180)
        } else if minHeart < 50 {
            return Int.random(in: 50 ..< 70)
        } else {
            return Int.random(in: minHeart ..< maxHeart)
        }
    }
    
    
    func getHeartBeatAnimationSpeed() -> Double {
        switch heartBeat ?? 50 {
        case 50..<70:
            return 0.3
        case 70..<90:
            return 0.5
        case 90..<120:
            return 0.7
        case 120..<140:
            return 0.8
        case 140..<200:
            return 1.0
        default:
            return 0.5
        }
    }
    
    //MARK: Timer Handler
    @objc func updateHeartRate() {
        self.heartBeat = getRandomHeartBeat()
        healthUpdater.updateHeartRate(heartRate: heartBeat)
    }
}
