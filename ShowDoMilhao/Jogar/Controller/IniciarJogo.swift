//
//  IniciarJogo.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 11/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

protocol IniciarJogoDelegate {
    func gravarPontuacao(pontuacao: Int)
}

class IniciarJogo: UIViewController {
    
    @IBOutlet weak var labelValorDaPergunta: UILabel!
    @IBOutlet weak var chamarPerguntaButton: UIButton!
    @IBOutlet weak var pararButton: UIButton!
    
    var delegate: IniciarJogoDelegate!
    
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
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Proxima Pergunta"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.configurarTela()
    }
    
    @IBAction func chamarPerguntaAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "PerguntaViewController") as! PerguntaViewController
        
        controller.pergunta = self.selecionarPergunta()
        controller.numeroPergunta = self.numeroPergunta
        controller.delegate = self
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setupScreen() {
        self.chamarPerguntaButton.layer.cornerRadius = self.chamarPerguntaButton.frame.height / 2
    }
    
    private func carregarPerguntas(){
        
        self.perguntasFaceis = perguntas.filter { $0.dificuldade == Dificuldade.FACIL}
        self.perguntasMedias = perguntas.filter { $0.dificuldade == Dificuldade.MEDIO}
        self.perguntasDificies = perguntas.filter { $0.dificuldade == Dificuldade.DIFICIL}
    }
    
    private func configurarTela(){
        let valor: Int = calcValorPergunta(numero: self.numeroPergunta)
        
        self.labelValorDaPergunta.text = "Valendo R$" + String(valor) + (self.numeroPergunta != 16 ? " mil" : " Milhao")
        
    }
    
    private func selecionarPergunta() -> Pergunta {
        
        if (self.numeroPergunta < 6){
            let number = Int.random(in: 0 ... self.perguntasFaceis.count)

            return self.perguntasFaceis[number]
        }else if (self.numeroPergunta < 11) {
            let number = Int.random(in: 0 ... self.perguntasMedias.count)

            return self.perguntasMedias[number]
        }else {
            let number = Int.random(in: 0 ... self.perguntasDificies.count)

            return self.perguntasDificies[number]
        }
    }
    
    private func calcValorPergunta(numero: Int) -> Int{
        
        if (numero < 1){
            return 0
        }else if (numero < 6){
            return numero
        }else if (numero < 11){
            return (numero - 5) * 10
        }else if (numero < 16){
            return (numero - 10) * 100
        }else{
            return 1
        }
    }
}

extension IniciarJogo: PerguntaViewControllerDelegate {
    
    
    func erroJogo(valor: Int) {
        self.navigationController?.popViewController(animated: true)
        
        self.delegate.gravarPontuacao(pontuacao: valor)
    }
    
    func acertoJogo(valor: Int) {
        self.numeroPergunta += 1
        
        self.navigationController?.popViewController(animated: true)
        
        if (self.numeroPergunta > 16 ) {
            
            self.delegate.gravarPontuacao(pontuacao: valor)
        }
    }
    
    func pararJogo(valor: Int) {
        
        self.navigationController?.popViewController(animated: true)
        
        self.delegate.gravarPontuacao(pontuacao: valor)
        
    }
}
