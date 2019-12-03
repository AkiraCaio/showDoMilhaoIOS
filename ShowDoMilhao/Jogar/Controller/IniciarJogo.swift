//
//  IniciarJogo.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 11/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import AVFoundation
import JGProgressHUD

protocol IniciarJogoDelegate {
    func gravarPontuacao(pontuacao: Int)
}

class IniciarJogo: UIViewController {
    
    @IBOutlet weak var labelValorDaPergunta: UILabel!
    @IBOutlet weak var chamarPerguntaButton: UIButton!
    @IBOutlet weak var pararButton: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    
    var delegate: IniciarJogoDelegate!
    
    //Enquanto menor que 6 apenas perguntas faceis, se maior que 6 comeca perguntas medias, se maior que 12 comeca perguntas dificeis.
    var numeroPergunta: Int = 1
    
    var perguntas: [Pergunta] = []
    
    var perguntasFaceis: [Pergunta] = []
    var perguntasMedias: [Pergunta] = []
    var perguntasDificies: [Pergunta] = []
    
    var perguntaSelecionada: Pergunta?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupScreen()
        
        self.carregarPerguntas()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Proxima Pergunta"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.configurarTela()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tocarSom()
        }
    }
    
    @IBAction func chamarPerguntaAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "PerguntaViewController") as! PerguntaViewController
        
        self.audioPlayer.pause()
        
        controller.pergunta = self.selecionarPergunta()
        controller.numeroPergunta = self.numeroPergunta
        controller.delegate = self
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func tocarSom() {
        
        var nomeSom: String = ""
        
        switch self.numeroPergunta {
        case 1:
            nomeSom = "1 mil reais"
        case 2:
            nomeSom = "2 mil reais"
        case 3:
            nomeSom = "3 mil reais"
        case 4:
            nomeSom = "4 mil reais"
        case 5:
            nomeSom = "5 mil reais"
        case 6:
            nomeSom = "10 mil reais"
        case 7:
            nomeSom = "20 mil reais"
        case 8:
            nomeSom = "30 mil reais"
        case 9:
            nomeSom = "40 mil reais"
        case 10:
            nomeSom = "50 mil reais"
        case 11:
            nomeSom = "100 mil reais"
        case 12:
            nomeSom = "200 mil reais"
        case 13:
            nomeSom = "300 mil reais"
        case 14:
            nomeSom = "400 mil reais"
        case 15:
            nomeSom = "500 mil reais"
        case 16:
            nomeSom = "1000 (milhao) mil de reais"
        default:
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: nomeSom, ofType: "mp3")!))
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
        } catch  {
            self.showToast(error: true, message: error.localizedDescription)
        }
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
            let number = Int.random(in: 0 ..< self.perguntasFaceis.count)
            
            return self.perguntasFaceis[number]
        }else if (self.numeroPergunta < 11) {
            let number = Int.random(in: 0 ..< self.perguntasMedias.count)
            
            return self.perguntasMedias[number]
        }else {
            let number = Int.random(in: 0 ..< self.perguntasDificies.count)
            
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
