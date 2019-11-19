//
//  HeaderTableView.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 14/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class HeaderTableView: UIView {
    
    let label: UILabel = {
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setupLayout() {
        
        self.addSubview(self.label)
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        ])
    }
}
