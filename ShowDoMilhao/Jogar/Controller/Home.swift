//
//  ProximaPerguntaViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import Firebase

class Home: UIViewController {
    
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var jogarButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configTela()
    }
    
    @IBAction func jogarAction(_ sender: Any) {
        
        let controller = (storyboard?.instantiateViewController(identifier: "IniciarJogo"))!
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func rankingAction(_ sender: Any) {
        	
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        try? Auth.auth().signOut()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configTela() {
        
        self.buttonLogout.layer.cornerRadius = self.buttonLogout.frame.height / 2
        self.jogarButton.layer.cornerRadius = self.jogarButton.frame.height / 2
        self.rankingButton.layer.cornerRadius = self.rankingButton.frame.height / 2
    }
    
}
