//
//  HalfCircle.swift
//  Earth Heroes
//
//  Created by Kuba Milcarz on 3/24/23.
//

import SwiftUI

struct HalfCircle: Shape {
    var clockwise: Bool
    
    init(clockwise: Bool) {
        self.clockwise = clockwise
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let yOffset = clockwise ? 0 : radius
        
        let startAngle = !clockwise ? Angle(degrees: 0) : Angle(degrees: 180)
        let endAngle = !clockwise ? Angle(degrees: 180) : Angle(degrees: 0)
        
        path.addArc(center: CGPoint(x: center.x, y: center.y + yOffset), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        path.closeSubpath()
        
        return path
    }
}
