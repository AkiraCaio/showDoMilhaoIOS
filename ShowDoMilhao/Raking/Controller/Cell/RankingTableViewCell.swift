//
//  RankingTableViewCell.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 24/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelPontos: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func bind (nome: String, pontos: Int){
        self.labelNome.text = nome
        self.labelPontos.text = String(pontos)
    }
    
}
