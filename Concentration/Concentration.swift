//
//  Concentration.swift
//  Concentration
//
//  Created by Feras Allaou on 1/17/19.
//  Copyright © 2019 Feras Allaou. All rights reserved.
//

import Foundation

struct Concentration
{

    private(set) var cards = [Card]()
    var flipCounts = 0
    
    private var indexOfOneAndOnlyFacedUpCard: Int? {
        get {
            
            return cards.indices.filter { cards[$0].isFaceUp}.oneAndOnly
        }   
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        flipCounts += 1
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index is not in the cards")
        if !cards[index].isMathced {
            if let matchIndex = indexOfOneAndOnlyFacedUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMathced = true
                    cards[index].isMathced = true
                }
                cards[index].isFaceUp = true
            }else{
                indexOfOneAndOnlyFacedUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "numberOfPairsOfCards(at: \(index): You must have at least one Card")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    

}

    extension Collection {
        var oneAndOnly: Element? {
            return count == 1 ? first: nil
        }
}

