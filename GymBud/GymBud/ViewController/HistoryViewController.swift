//
//  HistoryController.swift
//  GymBud
//
//  Created by Daniela Steinöcker on 27.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModalHandler {
    
    var delegate: AppDelegate!
    @IBOutlet weak var tableView: UITableView!
    var locationManager = LocationManager()
    var sessions:[Workout] = []
    
    func modalClosed() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = UIApplication.shared.delegate as? AppDelegate
        setupView()
    }
    
    
    func setupView() {
        queryAPI()
        
        registerTableCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func queryAPI(){
        let todoEndpoint: String = "http://felixneustifter.at:8888/workouts"
        AF.request(todoEndpoint)
            .responseJSON { response in
                guard (response.value != nil) else {
                    print("AL: response error!")
                    return
                }
                guard let json = response.value as? [[String:Any]] else {
                    //print(response.value)
                    print("AL: no json")
                    return
                }
    
                for workoutjson in json {
                    
                    guard let endDate = workoutjson["Created_date"] as? String else {
                        print("Could not get date from JSON")
                        return
                    }
                    guard let name = workoutjson["name"] as? String else {
                        print("Could not get name from JSON")
                        return
                    }
                    guard let workoutType = workoutjson["workout_type"] as? [String] else {
                        print("Could not get workout type from JSON")
                        return
                    }
                    /*
                    guard let burn = workout["burn"] as? String else {
                        print("Could not get burn from JSON")
                        return
                    }
                    */
                    let workout = Workout()
                    //let dateformatter = ISO8601DateFormatter()
                    //workout.date = dateformatter.date(from: endDate)
                    workout.date = endDate
                    workout.workoutType = workoutType.first
                   // session.burn = Double(burn)!
                    workout.burn = String(281)
                    workout.gym = name
                    self.sessions.append(workout)
                    //dump(workout)
                    
                }
                
                dump(self.sessions)
                self.tableView.reloadData()
        }
        
        
    }
    
    
    
    
    //MARK: Table View
    func registerTableCells(){
        var cellNib = UINib(nibName: "TopTableViewCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "TopTableViewCell")
        cellNib = UINib(nibName: "ExerciseTableViewCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "ExerciseTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count  + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return setupTopTableViewCell()
        case 1...Int.max:
            return setupExerciseViewCell(session: sessions[indexPath.row - 1])
        default:
            return UITableViewCell()
        }
    }
    
    func setupTopTableViewCell() -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell") as? TopTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.setUpHistoryControllerTopCell()
        
        return cell
    }
    
    func setupExerciseViewCell(session: Workout?) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell") as? ExerciseTableViewCell else {
            return UITableViewCell()
        }
       //let formatter = DateFormatter()
        //cell.exerciseImage.image = UIImage(data: (exercise?.image)!) ?? UIImage()
        cell.exerciseTitle.text = session?.workoutType ?? ""
        cell.exerciseDescription.text = "Name: " + session!.gym! + "\nDate: " + session!.date!.prefix(10)  + "\nCalories burned: " + session!.burn + " kcal"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Not click able!")
            // case 1...Int.max:
        //   openExerciseModal(exercise: exercises[indexPath.row - 1])
        default:
            print("Not click able!")
        }
    }
    
    func openUserSettingModal(){
        guard let userSettingView = storyboard?.instantiateViewController(withIdentifier: "UserSettingsViewController") as? UserSettingsViewController else {
            return
        }
        
        userSettingView.locationManager = locationManager
        userSettingView.modalHandler = self
        userSettingView.showBackBtn = false
        userSettingView.modalPresentationStyle = .overCurrentContext
        userSettingView.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.pushViewController(userSettingView, animated: true)
    }
    
    //MARK: Button Handler
    @objc func logoutBtn(){
        if UserPrefernces.isLoggedIn() {
            let alert = UIAlertController(title: "Logout", message: "Do you wanna logout of the application?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                UserPrefernces.setLoggedIn(loggedIn: false)
                self.openUserSettingModal()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
