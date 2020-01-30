//
//  StepCounter.swift
//  GymBud
//
//  Created by Reder on 24.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import Foundation
import CoreMotion

class StepCounter{
    var pedometer:CMPedometer?
    var healthUpater:HealthUpdater!
    var currentStepCounter:Int = 0
    var startStepCounter:Int?
    var timer:Timer!
    
    
    init(healthUpater: HealthUpdater) {
        self.healthUpater = healthUpater
        
    }

    func start(){
        pedometer = CMPedometer()
        pedometer!.startUpdates(from: Date()) { (data, error) in
            
            guard let numberOfSteps = data?.numberOfSteps else {
                return
            }
            
            if self.startStepCounter == nil {
                self.startStepCounter = Int(truncating: numberOfSteps)
                self.currentStepCounter = 1
                self.healthUpater.updateStepCounter(stepCounter: self.currentStepCounter)
                return
            }
            
            self.healthUpater.updateStepCounter(stepCounter: Int(truncating: numberOfSteps) - self.startStepCounter!)
            
        }
    }
    
    func startSimulation(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func getRandom() -> Int {
        return Int.random(in: 0 ... 1)
    }
    
    func stop(){
        pedometer = nil
        timer.invalidate()
    }
    
    @objc func update(){
        currentStepCounter = currentStepCounter + getRandom()
        healthUpater.updateStepCounter(stepCounter: currentStepCounter)
    }
}
