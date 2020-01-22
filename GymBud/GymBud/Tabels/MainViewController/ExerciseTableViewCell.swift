//
//  ExerciseTableViewCell.swift
//  GymBud
//
//  Created by itsedev on 22.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var exerciseDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //exerciseImage.layer.borderWidth = 2
        //exerciseImage.layer.borderColor = UIColor(red: 244/255.0, green: 81/255.0, blue: 30/255.0, alpha: 1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
