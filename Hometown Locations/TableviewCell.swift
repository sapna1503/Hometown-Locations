//
//  TableviewCell.swift
//  Hometown Locations
//
//  Created by Sapna Chandiramani on 10/31/17.
//  Copyright © 2017 Sapna Chandiramani. All rights reserved.
//

import UIKit

class TableviewCell: UITableViewCell {

  
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblCityState: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
