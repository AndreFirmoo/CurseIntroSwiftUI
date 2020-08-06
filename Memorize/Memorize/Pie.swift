//
//  Pie.swift
//  Memorize
//
//  Created by Andre Jardim Firmo on 06/08/20.
//  Copyright © 2020 Andre Jardim Firmo. All rights reserved.
//

import SwiftUI

struct Pie : Shape {
    var startAngle : Angle
    var endAngle : Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius =  min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians) ),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        p.addLine(to: center)
        
        return p
    }
}
