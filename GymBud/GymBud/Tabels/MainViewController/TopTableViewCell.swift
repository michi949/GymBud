//
//  TopTableViewCell.swift
//  GymBud
//
//  Created by itsedev on 22.01.20.
//  Copyright © 2020 Fh Ooe. All rights reserved.
//

import UIKit

class TopTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var topMessage: UILabel!
    @IBOutlet weak var showMeMyProfileBtn: UIButton!
    
    @IBOutlet weak var bottomMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 0.5 *  profileImage.bounds.size.width
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.clipsToBounds = true
        showMeMyProfileBtn.tintColor = UIColor(red: 244/255.0, green: 81/255.0, blue: 30/255.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
