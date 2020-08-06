//
//  Cardfy.swift
//  Memorize
//
//  Created by Andre Jardim Firmo on 06/08/20.
//  Copyright © 2020 Andre Jardim Firmo. All rights reserved.
//

import SwiftUI

struct Cardfy: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
        if isFaceUp{
                RoundedRectangle(cornerRadius: conerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: conerRadius).stroke( lineWidth: edgeLineWidth)
                content
            }else{
                    RoundedRectangle(cornerRadius: conerRadius).fill()
            }
        }
    }
    private let conerRadius: CGFloat = 10.0
    private let edgeLineWidth:CGFloat = 3
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardfy(isFaceUp: isFaceUp))
    }
}
