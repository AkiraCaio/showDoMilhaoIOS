//
//  ExtensionViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showToast(error: Bool, message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = error ? UIColor.red.withAlphaComponent(0.6) : UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(toastLabel)
        
        NSLayoutConstraint.activate([
            toastLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 86),
            toastLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            toastLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            toastLabel.bottomAnchor.constraint(equalTo: toastLabel.topAnchor, constant: 64)
        ])
        
        UIView.animate(withDuration: 0.15, delay: 0.01, options: .curveEaseOut, animations: {
            toastLabel.alpha = 1
        }, completion: { (_) in
            UIView.animate(withDuration: 3, delay: 0.01, options: .curveEaseIn, animations: {
                toastLabel.alpha = 0
            }, completion: { (_) in
                toastLabel.removeFromSuperview()
            })
        })
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
