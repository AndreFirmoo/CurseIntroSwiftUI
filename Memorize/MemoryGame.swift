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

struct MemoryGame <CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {cards.indices.filter { cards[$0].isFaceUp }.only}
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }

    mutating func choose(card: Card) {
        
        if  let chosenIndex = cards.fistIndex(matching: card) , !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potencioalMatching = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potencioalMatching].content{
                    cards[chosenIndex].isMatched = true
                    cards[potencioalMatching].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            }else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
      
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
