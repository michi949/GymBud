//
//  NotInRangeViewController.swift
//  GymBud
//
//  Created by itsedev on 20.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//

import UIKit
import Lottie

class NotInRangeViewController: UIViewController {
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var showProfilBtn: UIButton!
    var modalHandler: ModalHandler!
    var animationLocation: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: Setup View
    func setupView(){
        self.navigationItem.setHidesBackButton(true, animated: false);
        self.title = "Not In Range"
        
        startBtn.layer.cornerRadius = 4
        startBtn.backgroundColor = UIColor(red: 244/255.0, green: 81/255.0, blue: 30/255.0, alpha: 1.0)
        
        
        showProfilBtn.layer.cornerRadius = 4
        showProfilBtn.backgroundColor = UIColor(red: 244/255.0, green: 81/255.0, blue: 30/255.0, alpha: 1.0)
        
        setupAnimation()
    }
    
    func setupAnimation(){
        animationView.backgroundColor = .clear
        animationLocation = AnimationView()
        animationLocation.animation = Animation.named("1342-location")
        animationLocation.contentMode = .scaleAspectFill
        animationLocation.frame = animationView.bounds
        animationLocation.loopMode = .loop
        animationView.addSubview(animationLocation)
        animationView.bringSubviewToFront(animationLocation)
        animationLocation.play()
    }

    
    @IBAction func startBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showProfilBtn(_ sender: Any) {
    }
}
