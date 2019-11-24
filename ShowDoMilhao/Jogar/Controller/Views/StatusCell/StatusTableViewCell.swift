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
        
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(acerto: String, parar: String, erro: String) {
        
        let valor = Int(acerto)
        
        self.erroLabel.text = erro
        self.acertoLabel.text = acerto
        self.pararLabel.text = parar
        
    }
    
    
}
