//
//  HealthUpdater.swift
//  GymBud
//
//  Created by Reder on 26.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import Foundation

protocol HealthUpdater {
    func updateHeartRate(heartRate: Int)
    func updateStepCounter(stepCounter: Int)
    func updatekCal(kCalCounter: Int)
}
