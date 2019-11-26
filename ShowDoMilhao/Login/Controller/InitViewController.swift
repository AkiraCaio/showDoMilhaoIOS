//
//  ViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class InitViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var loginButton: UIButton!
    
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
        
        self.chamarMusicaTema()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let user = Auth.auth().currentUser {
            user.reload { (_) in
                self.handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
                    //            try? auth.signOut()
                    
                    if let user = user {
                        
                        // If user is auth
                        if (user.isEmailVerified) {
                            self.chamarTelaHome()
                        }else {
                            self.chamarTelaVerificarEmail()
                            
                        }
                    }
                })
            }
        }
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let controller = self.instanciaLogin() as! LoginViewController
        
        controller.delegate = self
        
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        
        self.present(controller, animated: true)
    }
    
    private func chamarTelaVerificarEmail() {
        let storyboard = UIStoryboard(name: "Cadastro", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "ConfirmarEmailViewController")
        
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        
        self.present(controller, animated: true)
    }
    
    private func chamarMusicaTema() {
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "trilhaSonora", ofType: "mp3")!))
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            self.audioPlayer.numberOfLoops = -1
        } catch  {
            self.showToast(error: true, message: error.localizedDescription)
        }
    }
    
    private func chamarTelaHome() {
        let storyboard = UIStoryboard(name: "Pergunta", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
        controller.delegate = self
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func instanciaLogin() -> UIViewController {
        return (storyboard?.instantiateViewController(withIdentifier: "LoginViewController"))!
    }
    
    private func instanciaCadastro() -> UIViewController {
        let storyboard = UIStoryboard(name: "Cadastro", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: "CadastroViewController")
    }
}

extension InitViewController: LoginViewControllerDelegate {
    
    func chamarTelaCadastro() {
        
        self.dismiss(animated: true)
        
        let controller = instanciaCadastro() as! CadastroViewController
        
        controller.delegate = self
        
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        
        self.present(controller, animated: true)
    }
}

extension InitViewController: CadastroViewControllerDelegate {
    
    func chamarTelaLoginDoCadastro() {
        
        self.dismiss(animated: true)
        
        let controller = self.instanciaLogin() as! LoginViewController
        
        controller.delegate = self
        
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        
        self.present(controller, animated: true)
        
    }
}

extension InitViewController: homeDelegate {
    func pausarMusicaTema() {
        self.audioPlayer.pause()
    }
    
    func playMusicaTema() {
        self.audioPlayer.play()
    }
    
    
}
