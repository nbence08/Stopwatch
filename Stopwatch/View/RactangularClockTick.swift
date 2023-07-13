//
//  ClockTick.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 07. 01..
//

import SwiftUI

struct RactangularClockTick: View {
    var angle: Double = 0.0
    var radius: Double = 150.0
    var center: CGPoint = CGPoint(x: 200, y: 200)
    var tickLength: Double = 15.0
    var tickWidth: Double = 1.0
    
    var body: some View {
        let radAngle: Double = angle * PI / 180.0
        let tickWidth: Double = tickWidth * PI / 180.0
        let cosAngle1 = cos(radAngle - tickWidth)
        let sinAngle1 = sin(radAngle - tickWidth)
        let cosAngle2 = cos(radAngle + tickWidth)
        let sinAngle2 = sin(radAngle + tickWidth)
        
        let tickStart1 = CGPoint(
            x: center.x + radius * cosAngle1,
            y: center.y + radius * sinAngle1
        )
        let tickStart2 = CGPoint(
            x: center.x + radius * cosAngle2,
            y: center.y + radius * sinAngle2
        )
        let tickEnd1 = CGPoint(
            x: center.x + (radius - tickLength) * cosAngle1,
            y: center.y + (radius - tickLength) * sinAngle1
        )
        let tickEnd2 = CGPoint(
            x: center.x + (radius - tickLength) * cosAngle2,
            y: center.y + (radius - tickLength) * sinAngle2
        )
        Path { path in
            path.move(
                to: tickStart1
            )
            path.addLine(
                to: tickEnd1
            )
            path.addLine(
                to: tickEnd2
            )
            path.addLine(
                to: tickStart2
            )
        }
    }
}

struct RectangularClockTick_Previews: PreviewProvider {
    static var previews: some View {
        RactangularClockTick(radius: 100, center: CGPoint(x: 200, y: 200))
    }
}
