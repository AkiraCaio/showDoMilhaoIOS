//
//  PerguntaViewController.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 14/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

protocol PerguntaViewControllerDelegate {
    func pararJogo(valor: Int)
    func erroJogo(valor: Int)
    func acertoJogo(valor: Int)
}

class PerguntaViewController: UIViewController {
    
    var numeroPergunta: Int?
    var pergunta: Pergunta?
    
    let cellSpacingHeight: CGFloat = 5
    
    var delegate: PerguntaViewControllerDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupNavigationItem()
        
        self.printarReposta()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc func pararAction() {
        
        let alert = UIAlertController(title: "Voce deseja parar?", message: "Caso pare voce ira ganhar todo o dinheiro acumaldo ate o momento", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Continuar o jogo", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Parar", style: .destructive) { (_) in
            
            if let numeroPergunta = self.numeroPergunta {
                self.delegate.pararJogo(valor: self.calcValorPerguntaParar(numero: numeroPergunta))
            }
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func printarReposta() {
        if let pergunta = self.pergunta {
            print(pergunta.resposta)
        }
    }
    
    private func setupNavigationItem() {
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "iconeDesistirPergunta"), style: .done, target: self, action: #selector(PerguntaViewController.pararAction)), animated: true)
        
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.red
    }
    
    private func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "AlternativasTableViewCell", bundle: nil), forCellReuseIdentifier: "AlternativasTableViewCell")
        self.tableView.register(UINib(nibName: "StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "StatusTableViewCell")
        
        self.configHeaderTableView()
    }
    
    private func configHeaderTableView() {
        if let pergunta = self.pergunta {
            
            let header = HeaderTableView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
            header.label.text = pergunta.titulo
            
            self.tableView.tableHeaderView = header
        }
    }
    
    private func calcValorPerguntaErro(numero: Int) -> Int {
        if ( numero != 16) {
            return self.calcValorPerguntaParar(numero: numero) / 2
        }else {
            return 0
        }
    }
    
    private func calcValorPerguntaParar(numero: Int) -> Int {
        
        if (numero < 2){
            return 0
        }else if (numero < 7){
            return (numero - 1) * 1000
        }else if (numero < 12){
            return (numero - 6) * 10 * 1000
        }else{
            return (numero - 11) * 100 * 1000
        }
    }
    
    private func calcValorPerguntaAcerto(numero: Int) -> Int{
        
        if (numero < 1){
            return 0
        }else if (numero < 6){
            return numero * 1000
        }else if (numero < 11){
            return (numero - 5) * 10 * 1000
        }else if (numero < 16){
            return (numero - 10) * 100 * 1000
        }else{
            return 1 * 1000 *  1000
        }
    }
    
    private func valorPerguntaAcerto(perguntaNumero: Int) -> String {
        
        let numero = self.calcValorPerguntaAcerto(numero: perguntaNumero)
        
        return "\(numero)"
        
    }
    
    private func valorPerguntaParar(perguntaNumero: Int) -> String {
        
        let numero = self.calcValorPerguntaParar(numero: perguntaNumero)
        
        return "\(numero) "
        
    }
    
    private func valorPerguntaErro(perguntaNumero: Int) -> String {
        
        let numero = self.calcValorPerguntaErro(numero: perguntaNumero)
        
        return "\(numero) "
        
    }
}

extension PerguntaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlternativasTableViewCell") as! AlternativasTableViewCell
            
            if let pergunta = self.pergunta {
                cell.bind(alternativa: pergunta.alternativas[indexPath.section])
            }
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatusTableViewCell") as! StatusTableViewCell
            
            if let perguntaAtual = self.numeroPergunta {
                
                cell.bind(acerto: self.valorPerguntaAcerto(perguntaNumero: perguntaAtual), parar: self.valorPerguntaParar(perguntaNumero: perguntaAtual), erro: self.valorPerguntaErro(perguntaNumero: perguntaAtual))
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let perguntaAtual = self.pergunta, let numeroPergunta = self.numeroPergunta {
            
            
            if ( (perguntaAtual.resposta - 1) == indexPath.section ) {
                self.delegate.acertoJogo(valor: self.calcValorPerguntaAcerto(numero: numeroPergunta))
            }else {
//                self.delegate.erroJogo(valor: self.calcValorPerguntaErro(numero: numeroPergunta))
            }
            
        }
    }
    
}
