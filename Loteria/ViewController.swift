//
//  ViewController.swift
//  Loteria
//
//  Created by Bruno Alves da Silva on 10/06/20.
//  Copyright © 2020 Bruno Alves da Silva. All rights reserved.
//

import UIKit

enum GameType: String {
    case megasena =  "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNumber) {
            result.append(randomNumber) // append - Adiciona o numero no array
        }
    }
    return result.sorted() // Deixa os numeros em forma ordenada
}

class ViewController: UIViewController {
    
    @IBOutlet weak var sgGameType: UISegmentedControl!
    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet var balls: [UIButton]!
    
    //Funcao onde mostra a tela para o usuario
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumber(for: .megasena)
    }
    
    func showNumber(for type: GameType) {
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
        case .megasena:
            game = 6>-<60
            balls.last!.isHidden = false
        case .quina:
            game = 5>-<80
            balls.last!.isHidden = true
        }
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
        }
    }
    
    @IBAction func generatorGame() {
        switch sgGameType.selectedSegmentIndex {
        case 0:
            showNumber(for: .megasena)
        default:
            showNumber(for: .quina)
        }
    }
}

