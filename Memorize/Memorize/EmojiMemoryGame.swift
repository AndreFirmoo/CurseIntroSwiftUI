//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Andre Jardim Firmo on 17/07/20.
//  Copyright © 2020 Andre Jardim Firmo. All rights reserved.
//
//  This file is ViewModel
//

import SwiftUI

class EmojiMemoryGame {
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","💀"]
        return  MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
       
    
    //MARK: - Access to the Model

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    //MARK: -Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}
