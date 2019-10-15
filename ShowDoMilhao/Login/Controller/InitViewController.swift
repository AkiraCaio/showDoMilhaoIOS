//
//  ViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class InitViewController: UIViewController {
    
    var iniciarJogoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Iniciar Jogo", for: UIControl.State.normal)
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(iniciarJogo(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Show do milhão"
        
        self.setupLayout()
    }
    
    //MARK: LAYOUT DA TELA
    func setupLayout (){
        self.setupButtonLayout()
    }
    
    func setupButtonLayout(){
        view.addSubview(self.iniciarJogoButton)
        
        self.iniciarJogoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.iniciarJogoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -16),
            self.iniciarJogoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            self.iniciarJogoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: INICIA JOGO
    @objc func iniciarJogo(sender: UIButton!){
        let storyboard = UIStoryboard(name: "Pergunta", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "ProximaPerguntaViewController") as! ProximaPerguntaViewController

        self.navigationController?.pushViewController(controller, animated: true)
    }
}

