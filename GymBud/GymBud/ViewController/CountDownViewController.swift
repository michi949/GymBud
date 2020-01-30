//
//  CountDownViewController.swift
//  GymBud
//
//  Created by Reder on 24.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import UIKit
import Lottie

class CountDownViewController: UIViewController {
    @IBOutlet weak var animationView: UIView!
    var animationCountDown: AnimationView!
    var modalHandler:ModalHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        animationView.backgroundColor = .clear
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }
    
    //MARK: Setup View
    func setupView(){
        animationCountDown = AnimationView()
        animationCountDown.animation = Animation.named("45-countdown")
        animationCountDown.contentMode = .scaleToFill
        animationCountDown.frame = animationView.bounds
        animationCountDown.loopMode = .playOnce
        animationCountDown.animationSpeed = 0.5
        animationView.addSubview(animationCountDown)
        animationView.bringSubviewToFront(animationCountDown)
        animationCountDown.play(completion: { (completed) in
            self.modalHandler.modalClosed()
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}
