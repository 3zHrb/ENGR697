//
//  CellTableViewCell.swift
//  ENGR679WG
//
//  Created by Abdulaziz Alharbi on 11/20/18.
//  Copyright © 2018 Abdulaziz Alharbi. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var bluetoothName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
