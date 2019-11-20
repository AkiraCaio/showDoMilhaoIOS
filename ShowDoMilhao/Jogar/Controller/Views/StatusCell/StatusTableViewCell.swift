//
//  StatusTableViewCell.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 19/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet weak var erroLabel: UILabel!
    @IBOutlet weak var acertoLabel: UILabel!
    @IBOutlet weak var pararLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
