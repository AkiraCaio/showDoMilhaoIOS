//
//  Pergunta.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import Foundation

class Pergunta {
    
    var id: Int
    var titulo: String
    var alternativas: [String]
    var resposta: Int
    var dificuldade: Dificuldade
    
    init(id: Int, titulo: String, alternativas: [String], resposta: Int, dificuldade: Dificuldade) {
        self.id = id
        self.titulo = titulo
        self.alternativas = alternativas
        self.resposta = resposta
        self.dificuldade = dificuldade
    }
}

enum Dificuldade {
    case FACIL
    case MEDIO
    case DIFICIL
}
