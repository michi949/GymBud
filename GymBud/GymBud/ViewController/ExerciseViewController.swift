//
//  ExerciseViewController.swift
//  GymBud
//
//  Created by Reder on 22.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import UIKit
import Lottie

class ExerciseViewController: UITableViewController, HealthUpdater, ModalHandler {
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var exercisseDescription: UILabel!
    @IBOutlet weak var rightDescribtion: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftDescribtion: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var musicInterpretLabel: UILabel!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var musicTitleImage: UIImageView!
    @IBOutlet weak var musicControlButton: UIButton!
    var modalHandler:ModalHandler!
    var exercise:Exercise!
    var animationHeartBeat: AnimationView!
    var isActive: Bool = false
    var heartBeatSensor:HeartBeatSensor!
    var stepCounter:StepCounter!
    var caloriesCalculator:CaloriesCalculator!
    var isCardio = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartBeatSensor = HeartBeatSensor(healthUpdater: self)
        stepCounter = StepCounter(healthUpater: self)
        caloriesCalculator = CaloriesCalculator(healthUpdater: self)
        
        setupView()
    }
    
    //MARK: SetupView
    func setupView(){
        
        setupAnimation()
        
        heartRateLabel.text = "-- bpm"
        rightDescribtion.text = "-- kCal"
        setupViewForExercisse()
        
        headerImage.image = UIImage(data: (exercise?.image)!) ?? UIImage()
        headerTitle.text = exercise.name
        exercisseDescription.text = exercise.descriptionText
        
    }
    
    func setupViewForExercisse(){
        switch exercise.name {
        case "Squats":
            leftImage.image = UIImage(named: "gym")
            leftDescribtion.text = "-- Reps"
            isCardio = false
        case "Treadmile":
            leftDescribtion.text = "-- Steps"
            isCardio = true
        case "Stepper":
            leftDescribtion.text = "-- Steps"
            isCardio = true
        case "Deadlifts":
            leftImage.image = UIImage(named: "gym")
            leftDescribtion.text = "-- Reps"
            isCardio = false
        case "Abs":
            leftImage.image = UIImage(named: "gym")
            leftDescribtion.text = "-- Reps"
            isCardio = false
        default:
            print("No value exercisse")
        }
    }
    
    
    func changeMusicForHeartRate(heartRate: Int){
        
        switch heartRate {
        case Int.min..<60:
            musicTitleImage.image = UIImage(named: "113444._SX360_QL80_TTD_")
            musicTitleLabel.text = "Yellow Sub Marine"
            musicInterpretLabel.text = "The Beatels"
        case 60..<100:
            musicTitleImage.image = UIImage(named: "highhopes")
            musicTitleLabel.text = "Hip Hopes"
            musicInterpretLabel.text = "Panic! At The Disco"
        case 100..<130:
            musicTitleImage.image = UIImage(named: "showtek")
            musicTitleLabel.text = "We Like To Party"
            musicInterpretLabel.text = "Showtek"
        case 130..<Int.max:
            musicTitleImage.image = UIImage(named: "sefa")
            musicTitleLabel.text = "Suffering Matters"
            musicInterpretLabel.text = "Sefa"
        default:
            musicTitleImage.image = UIImage(named: "sefa")
            musicTitleLabel.text = "Suffering Matters"
            musicInterpretLabel.text = "Sefa"
        }
        
    }
    
    func setupAnimation(){
        animationView.backgroundColor = .clear
        animationHeartBeat = AnimationView()
        animationHeartBeat.animation = Animation.named("4565-heartbeat-medical")
        animationHeartBeat.contentMode = .scaleAspectFill
        animationHeartBeat.frame = animationView.bounds
        animationHeartBeat.loopMode = .loop
        animationView.addSubview(animationHeartBeat)
        animationView.bringSubviewToFront(animationHeartBeat)
        animationHeartBeat.animationSpeed = 0.5
        animationHeartBeat.play()
    }
    
    //MARK: Modal
    func openCountDownModal(){
        guard let countDownView = storyboard?.instantiateViewController(withIdentifier: "CountDownViewController") as? CountDownViewController else {
            return
        }
        
        countDownView.modalHandler = self
        countDownView.modalPresentationStyle = .overCurrentContext
        countDownView.modalTransitionStyle = .coverVertical
        
        present(countDownView, animated: true, completion: nil)
    }
    
    func modalClosed() {
        if isActive {
            heartBeatSensor.start()
            stepCounter.startSimulation()
            caloriesCalculator.start()
        } else {
            heartBeatSensor.stop()
            stepCounter.stop()
            caloriesCalculator.stop()
        }
    }
    
    //MARK: Button Handler
    @IBAction func startStopBtn(_ sender: Any) {
        
        if isActive {
            openCountDownModal()
        } else {
            openCountDownModal()
        }
        
        isActive = !isActive
    }
    
    //MARK: Value Updater
    func updateHeartRate(heartRate: Int) {
        //animationHeartBeat.animationSpeed = CGFloat(heartBeatSensor.getHeartBeatAnimationSpeed())
        heartRateLabel.text = "\(heartRate) bpm"
        caloriesCalculator.sendHeartRate(heartRate: heartRate)
        changeMusicForHeartRate(heartRate: heartRate)
        
        if !animationHeartBeat.isAnimationPlaying {
            animationHeartBeat.play()
        }
    }
    
    func updateStepCounter(stepCounter: Int) {
        if isCardio {
            leftDescribtion.text = "\(stepCounter) Steps"
        } else {
            leftDescribtion.text = "\(stepCounter) Reps"
        }
    }
    
    func updatekCal(kCalCounter: Int) {
        rightDescribtion.text = "\(kCalCounter) kCal"
    }
    
}
