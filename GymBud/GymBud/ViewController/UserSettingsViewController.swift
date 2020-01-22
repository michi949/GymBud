//
//  UserSettingsViewController.swift
//  GymBud
//
//  Created by itsedev on 21.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//

import UIKit
import MapKit

class UserSettingsViewController: UITableViewController {
    @IBOutlet weak var profilView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var gymTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    var modalHandler:ModalHandler!
    var showBackBtn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: Setup View
    func setupView(){
        
        if !showBackBtn {
            self.navigationItem.setHidesBackButton(true, animated: false)
            self.title = "Create your Profile"
        } else {
            self.title = "Profile Settings"
        }
        
        
        profilView.layer.cornerRadius = 0.5 *  profilView.bounds.size.width
        profilView.layer.borderWidth = 2
        profilView.layer.borderColor = UIColor.lightGray.cgColor
        profilView.clipsToBounds = true
        
        
        startBtn.layer.cornerRadius = 4
        startBtn.backgroundColor = UIColor(red: 244/255.0, green: 81/255.0, blue: 30/255.0, alpha: 1.0)
        
    }

    //MARK: Button Handler
    @IBAction func startBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
