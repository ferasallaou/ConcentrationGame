//
//  Card.swift
//  Concentration
//
//  Created by Feras Allaou on 1/17/19.
//  Copyright © 2019 Feras Allaou. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hasValue: Int!
    
    static func ==(lhs: Card, rhs:Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMathced = false
    private var identifier: Int!
    
    private static var identifierFactory = 0
    
    private static func createIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init(){
        self.identifier = Card.createIdentifier()
    }
}
