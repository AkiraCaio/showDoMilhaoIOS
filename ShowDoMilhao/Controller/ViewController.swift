//
//  ViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "perguntas", ofType: "txt")!)

        let s = StreamReader(url: path)
        while !s!.isAtEOF{
            if let line = s?.nextLine() {
                print(line)
            }
        }
       
    }
}

