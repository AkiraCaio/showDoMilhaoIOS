//
//  RankingViewController.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 24/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import Firebase

class RankingViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    var ranking: [Jogador] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        
        self.setupTableView()
        self.buscarPessoasRanking()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UINib(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: "RankingTableViewCell")
    }
    
    private func buscarPessoasRanking() {
        ref.child("users").queryOrdered(byChild: "pontos").observe(.childAdded) { (snapshot) in

            let jogador = (snapshot.value as! [String: Any])
            self.ranking.append(
                Jogador(nome: jogador["username"] as! String, pontuacao: jogador["pontos"] as! Int)
            )
            
            self.tableView.reloadData()
            
        }
    }
}


extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ranking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell") as! RankingTableViewCell
        
        let jogador: Jogador = self.ranking[indexPath.row]

        cell.bind(nome: jogador.nome, pontos: jogador.pontuacao)
        
        return cell
    }
    
    
}
