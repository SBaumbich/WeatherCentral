//
//  DailyWeatherTableViewCell.swift
//  Weather Now
//
//  Created by Scott Baumbich on 11/5/15.
//  Copyright © 2015 Scott Baumbich. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet var temperatureLable: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var dayLable: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
