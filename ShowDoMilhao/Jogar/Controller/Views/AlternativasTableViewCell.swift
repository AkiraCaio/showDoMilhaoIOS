//
//  AlternativasTableViewCell.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 12/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class AlternativasTableViewCell: UITableViewCell {
    
    let viewInterna: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .blue
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        view.layer.cornerRadius = 10

        return view
    }()
    
    let labelAlternativa: UILabel = {
        let lbl = UILabel()

        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white

        return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configScreen()
        self.layoutSubviews()
    }
    
    func bind(alternativa: String) {
        self.labelAlternativa.text = alternativa
    }

    private func configScreen() {

        selectionStyle = .none
        
        self.configView()
        self.configLabelAlternativa()
    }
    
    private func configLabelAlternativa() {
        self.viewInterna.addSubview(self.labelAlternativa)
        
        NSLayoutConstraint.activate([
            self.labelAlternativa.topAnchor.constraint(equalTo: self.viewInterna.topAnchor, constant: 8),
            self.labelAlternativa.bottomAnchor.constraint(equalTo: self.viewInterna.bottomAnchor, constant: -8),
            self.labelAlternativa.centerXAnchor.constraint(equalTo: self.viewInterna.centerXAnchor)
        ])
    }
    
    private func configView() {
        self.addSubview(self.viewInterna)
        
        NSLayoutConstraint.activate([
            self.viewInterna.topAnchor.constraint(equalTo: self.topAnchor),
            self.viewInterna.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.viewInterna.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.viewInterna.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        ])
    }
}
