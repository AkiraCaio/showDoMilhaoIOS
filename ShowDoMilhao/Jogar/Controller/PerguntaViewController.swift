//
//  PerguntaViewController.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 14/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class PerguntaViewController: UIViewController {
    
    var pergunta: Pergunta?
    
    let cellSpacingHeight: CGFloat = 5

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.setupTableView()
    }
    
    private func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "AlternativasTableViewCell", bundle: nil), forCellReuseIdentifier: "AlternativasTableViewCell")

        
        self.configHeaderTableView()
    }
    
    private func configHeaderTableView() {
        if let pergunta = self.pergunta {
           
            let header = HeaderTableView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
            header.label.text = pergunta.titulo
            
            self.tableView.tableHeaderView = header
        }
    }
    
}

extension PerguntaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
     }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 4
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlternativasTableViewCell") as! AlternativasTableViewCell
                
        if let pergunta = self.pergunta {
            cell.bind(alternativa: pergunta.alternativas[indexPath.section])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(pergunta!.alternativas[indexPath.section])
    }
}
