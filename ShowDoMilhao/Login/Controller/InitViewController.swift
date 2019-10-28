//
//  ViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import Firebase


class InitViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var iniciarJogoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Iniciar Jogo", for: UIControl.State.normal)
//        button.setTitleColor(.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(iniciarJogo(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                // If user is auth
            }else{
                self.chamarTelaLogin()
            }
        })
    }
    
    //MARK: LAYOUT DA TELA
    func setupLayoutAfterLogin (){
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
    
    private func chamarTelaLogin() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        
        self.present(controller, animated: true)	
    }
}
