//
//  IniciarJogo.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 11/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class IniciarJogo: UIViewController {
    
    @IBOutlet weak var labelValorDaPergunta: UILabel!
    @IBOutlet weak var chamarPerguntaButton: UIButton!
    @IBOutlet weak var pararButton: UIButton!
    
    //Enquanto menor que 6 apenas perguntas faceis, se maior que 6 comeca perguntas medias, se maior que 12 comeca perguntas dificeis.
    var numeroPergunta: Int = 1
    
    let perguntas: [Pergunta] = {
        var perguntas: [Pergunta] = []
        perguntas = StreamReader.readFile()
        
        return perguntas
    }()
    
    var perguntasFaceis: [Pergunta] = []
    var perguntasMedias: [Pergunta] = []
    var perguntasDificies: [Pergunta] = []
    
    var perguntaSelecionada: Pergunta?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.carregarPerguntas()
        self.setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.configurarTela()
    }
    
    @IBAction func chamarPerguntaAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "PerguntaViewController") as! PerguntaViewController
        
        controller.pergunta = self.selecionarPergunta()
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func pararAction(_ sender: Any) {
//        let confirmarParar = UIAlertController(title: "Deseja Parar?", message: "Se parar voce irar ganhar R$ \() Mil", preferredStyle: .actionSheet)
        
    }
    
    private func setupScreen() {
        self.chamarPerguntaButton.layer.cornerRadius = self.chamarPerguntaButton.frame.height / 2
        self.pararButton.layer.cornerRadius = self.pararButton.frame.height / 2
    }
    
    private func selecionarPergunta() -> Pergunta {
        let number = Int.random(in: 0 ... 5)

        if (self.numeroPergunta < 6){
            return self.perguntasFaceis[number]
        }else if (self.numeroPergunta < 11) {
            return self.perguntasMedias[number]
        }else {
            return self.perguntasDificies[number]
        }
    }
    
    private func carregarPerguntas(){
        
        self.perguntasFaceis = perguntas.filter { $0.dificuldade == Dificuldade.FACIL}
        self.perguntasMedias = perguntas.filter { $0.dificuldade == Dificuldade.MEDIO}
        self.perguntasDificies = perguntas.filter { $0.dificuldade == Dificuldade.DIFICIL}
    }
    
    private func configurarTela(){
        let valor: Int = calcValorPergunta()
        
        self.labelValorDaPergunta.text = "Valendo R$" + String(valor) + (self.numeroPergunta != 16 ? " mil" : " Milhao")
        	
    }
    
    private func calcValorPergunta() -> Int{
        if (self.numeroPergunta < 6){
            return self.numeroPergunta
        }else if (self.numeroPergunta < 11){
            return self.numeroPergunta * 10
        }else if (self.numeroPergunta < 16){
            return self.numeroPergunta * 100
        }else{
            return 1
        }
    }
}
