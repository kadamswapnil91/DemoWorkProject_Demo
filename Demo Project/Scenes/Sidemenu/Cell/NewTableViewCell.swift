//
//  NewTableViewCell.swift
//  Demo Project
//
//  Created by Apple on 26/06/22.
//

import UIKit
import IQKeyboardManagerSwift

class NewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Outlets
    @IBOutlet weak var lbl_settings: UILabel!
    @IBOutlet weak var img_images: UIImageView!
    @IBOutlet weak var notificationCountLabel: UILabel!
    var notificationCount: Int? {
        didSet {
            if let count = notificationCount, count != 0  {
                notificationCountLabel.text = "\(count)"
                notificationCountLabel.isHidden = false
            }
            else {
                notificationCountLabel.text = ""
                notificationCountLabel.isHidden = true
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


    func setContentData(image: UIImage ,title: String, notificationCount: Int? = nil ) {
        self.notificationCount = notificationCount
        lbl_settings.text = title
        img_images.image = image
    }

    

}
