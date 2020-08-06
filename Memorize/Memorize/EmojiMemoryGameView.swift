//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Andre Jardim Firmo on 16/07/20.
//  Copyright © 2020 Andre Jardim Firmo. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        Grid (viewModel.cards)  { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                }
            .padding(5)
            .foregroundColor(Color.orange)
            
    }
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
            }
        }
    func body(for size: CGSize) -> some View{
        ZStack{
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: conerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: conerRadius).stroke( lineWidth: edgeLineWidth)
                Text(card.content)
            }else{
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: conerRadius).fill()
                }
               
            }
        }
        .font(Font.system(size: min(size.width, size.height) * fontScaleFactor))
    }
    //MARK: - Drawing Constants
    
    let conerRadius: CGFloat = 10.0
    let edgeLineWidth:CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
