//
//  TickedCircle.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 07. 01..
//

import SwiftUI

let PI: Double = 3.14159265358979323846

struct TickedCircle: View {
    private let smallTickAngles: [Double] = [30, 60, 120, 150, 210, 240, 300, 330]
    private let bigTickAngles: [Double] = [0, 90, 180, 270]
    
    var radius: Double = 150.0
    
    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x: width/2, y: radius)
            
            let smallTickWidth = max(radius / 300, 0.5)
            let smallTickLength = max(radius / 10, 1)
            let bigTickWidth = max(radius / 150.0, 1)
            let bigTickLength = max(radius / 7, 2)
            
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 2 * radius)
                .padding(.leading, width/2 - radius)
            
            ForEach(smallTickAngles, id: \.magnitude) {angle in
                RactangularClockTick(angle: angle,
                          radius: radius,
                          center: center,
                          tickLength: smallTickLength,
                          tickWidth: smallTickWidth
                )
            }
            ForEach(bigTickAngles, id: \.magnitude) {angle in
                RactangularClockTick(angle: angle,
                          radius: radius,
                          center: center,
                          tickLength: bigTickLength,
                          tickWidth: bigTickWidth
                )
            }
        }
        .foregroundColor(.primary)
        .scaledToFit()
        .frame(minWidth: 2 * radius, maxHeight: 2 * radius)
    }
}

struct TickedCircle_Previews: PreviewProvider {
    static var previews: some View {
        TickedCircle()
    }
}
