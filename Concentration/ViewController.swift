//
//  ViewController.swift
//  Concentration
//
//  Created by Feras Allaou on 1/17/19.
//  Copyright © 2019 Feras Allaou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var emojisArr = ["",""]
    private var emojis = [Card:String]()
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    

    @IBAction func startNewGame(_ sender: Any) {
        startNewGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
         updateLabel()
        }
    }
    
    func updateLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips \(game.flipCounts)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateLabel()
            updateViewFromModel()
        }
    }
    
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            }else{
                button.backgroundColor = card.isMathced ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle("", for: UIControl.State.normal)
            }
        }
}
    

    func emoji(for card: Card) -> String {
        if emojis[card] == nil, emojisArr.count > 0 {
            let randomIndex = emojisArr.count.arc4random
            emojis[card] = emojisArr.remove(at: randomIndex)
        }
        
        return emojis[card] ?? "?"
    }
    
    
    var themes = [
        ["👻","🎃","🧙🏻‍♀️","🍬","🍾","♟","🗿"],
        ["😀","😅","😇","🥰","😘","😛","🤩"],
        ["🐶","🐸","🐒","🐥","🐝","🦄","🐍"],
        ["🍏","🍒","🍠","🥞","🥗","🍦","🥜"],
        ["⚽️","🏑","🤽🏻‍♀️","🏊🏻‍♀️","🎭","🎲","🎳"],
        ["🚗","🚨","🚥","⛺️","🕍","📸","💸"]
    ]
    
    
    func startNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojisArr = themes[themes.count.arc4random]
        emojis = [Card:String]()
        updateLabel()
        updateViewFromModel()
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
