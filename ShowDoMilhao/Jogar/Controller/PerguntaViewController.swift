//
//  PerguntaViewController.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 14/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import Firebase

class PerguntaViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var pergunta: Pergunta?
    var numeroPergunta: Int = 10
    
    let cellSpacingHeight: CGFloat = 5
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
        self.setupTableView()
        self.setupNavigationItem()
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
        print("funciona buceta")
        
        let alert = UIAlertController(title: "Voce deseja parar?", message: "Caso pare voce ira ganhar todo o dinheiro acumaldo ate o momento", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Continuar o jogo", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Parar", style: .destructive) { (_) in
            
//            guard let key = self.ref.child("users").childByAutoId().key else { return }
            let key = Auth.auth().currentUser!.uid
            
            let post = ["uid": Auth.auth().currentUser?.email ?? "-",
                        "pontos": self.numeroPergunta] as [String : Any]
            
            let childUpdates = ["/users/\(key)": post]
            
            self.ref.updateChildValues(childUpdates)
            
            self.navigationController?.popViewController(animated: true)
            
        })
        
        self.present(alert, animated: true, completion: nil)
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
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
