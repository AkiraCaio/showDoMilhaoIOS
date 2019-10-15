//
//  ProximaPerguntaViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class ProximaPerguntaViewController: UIViewController {
    
    let perguntas: [Pergunta] = StreamReader.readFile()
    
    let oi = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
