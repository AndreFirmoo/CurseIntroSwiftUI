//
//  MemoryGame.swift
//  Memorize
//
//  Created by Andre Jardim Firmo on 17/07/20.
//  Copyright © 2020 Andre Jardim Firmo. All rights reserved.
//
//  This file is a kind of Model of app
//


import Foundation

struct MemoryGame <CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int)-> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.shuffle()
            cards.append(Card(content: content, id: pairIndex * 2 + 1 ))
            cards.shuffle()
        }
    }
    
    struct Card : Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
