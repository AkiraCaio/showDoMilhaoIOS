//
//  ProximaPerguntaViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

protocol homeDelegate {
    func pausarMusicaTema()
    func playMusicaTema()
}

class Home: UIViewController {
    
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var jogarButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonLogout: UIButton!
    
    var ref: DatabaseReference!
    
    var delegate: homeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        self.configTela()
    }
    
    
    @IBAction func jogarAction(_ sender: Any) {
            
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Carregando Perguntas..."
        hud.show(in: self.view)
        
        var perguntas: [Pergunta] = []

        ref.child("questoes").observeSingleEvent(of: .value, with: { (snapshot) in
                        
            for perguntaChildren in snapshot.children {
                
                let perguntaData = perguntaChildren as! DataSnapshot
                let pergunta = perguntaData.value as! [String: Any]
                
                
                perguntas.append(
                    Pergunta(id: pergunta["id"] as! Int, titulo: pergunta["pergunta"] as! String, alternativas: pergunta["opcoes"] as! [String], resposta: pergunta["resposta"] as! Int, dificuldade: Dificuldade(rawValue: pergunta["dificuldade"] as! String ) ?? Dificuldade.FACIL)
                    //                Pergunta(nome: jogador["username"] as! String, pontuacao: jogador["pontos"] as! Int)
                )
            }
            
            hud.dismiss()
            
            let controller = (self.storyboard?.instantiateViewController(identifier: "IniciarJogo")) as! IniciarJogo
            
            controller.perguntas = perguntas
            
            self.delegate.pausarMusicaTema()
            controller.delegate = self
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        })
        
        
        
    }
    
    @IBAction func rankingAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Ranking", bundle: nil)
        
        let controller = (storyboard.instantiateViewController(identifier: "RankingViewController")) as! RankingViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        try? Auth.auth().signOut()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate.playMusicaTema()
        
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

extension Home: IniciarJogoDelegate {
    
    
    func gravarPontuacao(pontuacao: Int) {
        
        self.navigationController?.popViewController(animated: true)
        
        let key = Auth.auth().currentUser!.uid
        
        ref.child("users").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let pontuacaoAtual = value?["pontos"] as? Int ?? 0
            
            self.ref.child("users").child(key).child("pontos").setValue( pontuacao >  pontuacaoAtual ? pontuacao : pontuacaoAtual)
            
        }) { (error) in
            self.showToast(error: true, message: error.localizedDescription)
        }
    }
    
}
