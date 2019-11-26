//
//  ConfirmarEmailViewController.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 26/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class ConfirmarEmailViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
            user.reload { (_) in
                self.verificarEmail()
            }
        }
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { (_) in
            self.verificarEmail()
        })
    }
    
    private func verificaSeEmailFoiVerificado() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if let user = Auth.auth().currentUser {
                user.reload { (_) in
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.verificarEmail()
                    }
                }
            }
        }
    }
    
    private func verificarEmail() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            if let user = user {
                user.reload { (_) in
                    
                    if (user.isEmailVerified) {
                        self.dismiss(animated: true)
                    }else {
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = "Confirme o seu email"
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 15)
                    }
                }
                self.verificaSeEmailFoiVerificado()
                
            }
            
        })
        
    }
}
