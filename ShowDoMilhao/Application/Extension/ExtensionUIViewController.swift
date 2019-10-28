//
//  ExtensionViewController.swift
//  ShowDoMilhao
//
//  Created by Caio Vinicius Pinho Vasconcelos on 05/10/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    class StreamReader {
        let encoding: String.Encoding
        let chunkSize: Int
        let fileHandle: FileHandle
        var buffer: Data
        let delimPattern : Data
        var isAtEOF: Bool = false
        
        init?(url: URL, delimeter: String = "\n", encoding: String.Encoding = .utf8, chunkSize: Int = 4096)
        {
            guard let fileHandle = try? FileHandle(forReadingFrom: url) else { return nil }
            self.fileHandle = fileHandle
            self.chunkSize = chunkSize
            self.encoding = encoding
            buffer = Data(capacity: chunkSize)
            delimPattern = delimeter.data(using: .utf8)!
        }
        
        deinit {
            fileHandle.closeFile()
        }
        
        func rewind() {
            fileHandle.seek(toFileOffset: 0)
            buffer.removeAll(keepingCapacity: true)
            isAtEOF = false
        }
        
        func nextLine() -> String? {
            if isAtEOF { return nil }
            
            repeat {
                if let range = buffer.range(of: delimPattern, options: [], in: buffer.startIndex..<buffer.endIndex) {
                    let subData = buffer.subdata(in: buffer.startIndex..<range.lowerBound)
                    let line = String(data: subData, encoding: encoding)
                    buffer.replaceSubrange(buffer.startIndex..<range.upperBound, with: [])
                    return line
                } else {
                    let tempData = fileHandle.readData(ofLength: chunkSize)
                    if tempData.count == 0 {
                        isAtEOF = true
                        return (buffer.count > 0) ? String(data: buffer, encoding: encoding) : nil
                    }
                    buffer.append(tempData)
                }
            } while true
        }
                
        static func readFile() -> [Pergunta] {
            var perguntas: [Pergunta] = []
            
            //Conta o ID das perguntas
            var countID: Int = 0
            //Conta quantidade de #
            var countDificuldade: Int = -1
            
            var pergunta: Pergunta = Pergunta(id: 0)
            
            let path = URL(fileURLWithPath: Bundle.main.path(forResource: "perguntas", ofType: "txt")!)
            
            if let s = StreamReader(url: path){
                
                while !s.isAtEOF{
                    if (pergunta.id != countID){
                        pergunta = Pergunta(id: countID)
                    }
                    
                    guard let line = s.nextLine() else { break }
                    
                    if (!line.isEmpty){
                        
                        if (countDificuldade < 3) {
                            
                            switch line.prefix(1) {
                                
                            case "#":
                                countDificuldade += 1
                                
                                if (countDificuldade == 3) {
                                    countID = 0
                                }
                                
                            case "1", "2", "3":
                                pergunta.alternativas.append(line)
                                
                            case "4":
                                pergunta.alternativas.append(line)
                                
                                switch countDificuldade {
                                case 0:
                                    pergunta.dificuldade = .FACIL
                                case 1:
                                    pergunta.dificuldade = .MEDIO
                                case 2:
                                    pergunta.dificuldade = .DIFICIL
                                default:
                                    break
                                }
                                
                                perguntas.append(pergunta)
                                
                                countID += 1
                                
                            default:
                                pergunta.titulo = line
                            }
                            
                        }else{
                            perguntas[countID].resposta = Int(line) ?? 0
                            countID += 1
                        }
                    }
                }
            }
            
            return perguntas
        }
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
