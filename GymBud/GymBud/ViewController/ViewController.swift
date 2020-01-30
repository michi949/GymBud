//
//  ViewController.swift
//  GymBud
//
//  Created by Reder on 20.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModalHandler {
    @IBOutlet weak var tableView: UITableView!
    var delegate: AppDelegate!
    var coreDataManager:CoreDataManager!
    var exercises:[Exercise] = []
    var locationManager:LocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = UIApplication.shared.delegate as? AppDelegate
        coreDataManager = CoreDataManager(delegate: delegate)
        locationManager = LocationManager()
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
        
        let image = UIImage(systemName: "arrow.right.to.line.alt")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(logoutBtn))
        
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
        
        userSettingView.locationManager = locationManager
        userSettingView.modalHandler = self
        userSettingView.showBackBtn = false
        userSettingView.modalPresentationStyle = .overCurrentContext
        userSettingView.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.pushViewController(userSettingView, animated: true)
    }
    
    func openExerciseModal(exercise: Exercise?){
        guard let exerciseView = storyboard?.instantiateViewController(withIdentifier: "ExerciseViewController") as? ExerciseViewController else {
            return
        }
        
        exerciseView.exercise = exercise
        exerciseView.modalHandler = self
        exerciseView.modalPresentationStyle = .overCurrentContext
        exerciseView.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.pushViewController(exerciseView, animated: true)
    }
    
    func openHistoryView(){
        guard let historyView = storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController else {
            return
        }
        
        self.navigationController?.pushViewController(historyView, animated: true)
    }
    
    //MARK: Protocol
    func modalClosed() {
        if !checkUserSettings() {
            openUserSettingModal()
        }
    }
    
    //MARK: Functions
    func checkUserSettings() -> Bool {
        return UserPrefernces.isLoggedIn()
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
        cellNib = UINib(nibName: "HistoryTableViewCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "HistoryTableViewCell")

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return setupTopTableViewCell()
        case 1:
            return setUpHistorySegueCell()
        case 2...Int.max:
            return setupExerciseViewCell(exercise: exercises[indexPath.row - 2])
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
    
    func setUpHistorySegueCell() -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        /*
        cell.imageView?.image = UIImage(named: "bucket_list")
        cell.selectionStyle = .none
        cell.bottomMessage.text = "View Workout History"
        cell.topMessage.text = ""
        cell.showMeMyProfileBtn.isHidden = true
        */
        return cell
    }
    
    func setupExerciseViewCell(exercise: Exercise?) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell") as? ExerciseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.exerciseImage.image = UIImage(data: (exercise?.image)!) ?? UIImage()
        cell.exerciseTitle.text = exercise?.name ?? ""
        cell.exerciseDescription.text = exercise?.descriptionText ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Not click able!")
        case 1:
            openHistoryView()
        case 2...Int.max:
            openExerciseModal(exercise: exercises[indexPath.row - 2])
        default:
            print("Not click able!")
        }
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

