//
//  UserSettingsViewController.swift
//  GymBud
//
//  Created by Reder on 21.01.20.
//  Copyright © 2020 Reder. All rights reserved.
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
    var locationManager:LocationManager!
    
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
        
        setUserInformations()
        profilView.layer.cornerRadius = 0.5 *  profilView.bounds.size.width
        profilView.layer.borderWidth = 2
        profilView.layer.borderColor = UIColor.lightGray.cgColor
        profilView.clipsToBounds = true
        
        
        startBtn.layer.cornerRadius = 4
        startBtn.backgroundColor = UIColor(red: 244/255.0, green: 81/255.0, blue: 30/255.0, alpha: 1.0)
        
        setMap()
    }
    
    
    func setMap(){
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        updateMapWithLocation()
    }
    
    func updateMapWithLocation(){
        if let region = locationManager.getLocationRegion() {
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationManager.getLocation()
            annotation.title = "You"
            annotation.subtitle = "current location"
            mapView.addAnnotation(annotation)
        }
    }

    //MARK: Button Handler
    @IBAction func startBtn(_ sender: Any) {
        
        if saveUserInformations() && !UserPrefernces.isLoggedIn() {
            UserPrefernces.setLoggedIn(loggedIn: true)
            navigationController?.popViewController(animated: true)
        } else {
            print("User can not be saved!")
        }
        
    }
    
    //MARK: Functions
    func saveUserInformations() -> Bool{
        let name = nameTextField.text ?? ""
        let age = Int(ageTextField.text ?? "0")
        let height = Double(heightTextField.text ?? "0.0")
        let weight = Double(weightTextField.text ?? "0.0")

        if name == "" || age == 0 || height == 0.0 || weight == 0.0 {
            return false
        }
        
        UserPrefernces.setName(name: name)
        
        UserPrefernces.setAge(age: age ?? 0)
        
        UserPrefernces.setHeight(height: height ?? 0.0)
        
        UserPrefernces.setWeight(weight: weight ?? 0.0)
        
        //TODO: Check over textfield the posisiton of the Gym and enter it here!
        UserPrefernces.setPositionOfGym(lat: 48.292116, long: 14.304906, gymName: "John Reed Linz")
        
        
        return true
    }
    
    func setUserInformations(){
        nameTextField.text = UserPrefernces.getName()
        
        let age = UserPrefernces.getAge()
        if age == 0 {
             ageTextField.text = ""
        } else {
            ageTextField.text = String(age)
        }
        
        let height = UserPrefernces.getHeight()
        if height == 0.0 {
             heightTextField.text = ""
        } else {
            heightTextField.text = String(height)
        }
    
        
        let weight = UserPrefernces.getWeight()
        if weight == 0.0 {
             weightTextField.text = ""
        } else {
            weightTextField.text = String(weight)
        }
    
        gymTextField.text = UserPrefernces.getPositionOfGym().gymName
    }
}
