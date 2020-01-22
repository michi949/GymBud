//
//  ViewController.swift
//  GymBud
//
//  Created by itsedev on 20.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModalHandler {
    @IBOutlet weak var tableView: UITableView!
    var delegate: AppDelegate!
    var coreDataManager:CoreDataManager!
    var exercises:[Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = UIApplication.shared.delegate as? AppDelegate
        coreDataManager = CoreDataManager(delegate: delegate)
        setupView()
    }
    
    
    func setupView() {
        if checkUserSettings() {
            if !checkInRange(){
                openNotInRangeModal()
            }
        } else {
            openUserSettingModal()
        }
        
        coreDataManager.initAllExercises()
        exercises = coreDataManager.fetchAllExercises(context: .parent)
        
        registerTableCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    
    //MARK: Modal
    func openNotInRangeModal(){
        guard let notInRangeView = storyboard?.instantiateViewController(withIdentifier: "NotInRangeViewController") as? NotInRangeViewController else {
            return
        }
        
        notInRangeView.modalHandler = self
        notInRangeView.modalPresentationStyle = .overCurrentContext
        notInRangeView.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.pushViewController(notInRangeView, animated: true)
    }
    
    
    func openUserSettingModal(){
        guard let userSettingView = storyboard?.instantiateViewController(withIdentifier: "UserSettingsViewController") as? UserSettingsViewController else {
            return
        }
        
        userSettingView.modalHandler = self
        userSettingView.showBackBtn = false
        userSettingView.modalPresentationStyle = .overCurrentContext
        userSettingView.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.pushViewController(userSettingView, animated: true)
    }
    
    //MARK: Protocol
    func modalClosed() {
        if checkUserSettings() {
            
        }
    }
    
    //MARK: Functions
    func checkUserSettings() -> Bool {
        
        return true
    }
    
    func checkInRange() -> Bool {
        
        return false
    }
    
    
    //MARK: Table View
    func registerTableCells(){
        var cellNib = UINib(nibName: "TopTableViewCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "TopTableViewCell")
        cellNib = UINib(nibName: "ExerciseTableViewCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "ExerciseTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return setupTopTableViewCell()
        case 1...Int.max:
            return setupExerciseViewCell(exercise: nil )//exercises[indexPath.row - 1])
        default:
            return UITableViewCell()
        }
    }
    
    func setupTopTableViewCell() -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell") as? TopTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func setupExerciseViewCell(exercise: Exercise?) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell") as? ExerciseTableViewCell else {
            return UITableViewCell()
        }
        
        //cell.exerciseImage.image = UIImage(data: (exercise?.image)!) ?? UIImage()
        //cell.exerciseTitle.text = exercise?.name ?? ""
        //cell.exerciseDescription.text = exercise?.description ?? ""
        
        return cell
    }
}

