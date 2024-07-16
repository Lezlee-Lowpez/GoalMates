//
//  FeedTableViewCell.swift
//  GoalMates
//
//  Created by Lesley Lopez on 5/7/24.
//

import UIKit

class FeedTableViewCell: UITableViewCell {


    @IBOutlet weak var useNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalLabel2: UILabel!
    @IBOutlet weak var goalLabel3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
