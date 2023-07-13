//
//  Indicator.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 07. 01..
//

import SwiftUI

struct Indicator: View {
    var radius: Double = 150
    var innerRadius: Double = 5
    var indicatorLength: Double = 150
    var color: Color = .primary
    var indicatorAngle: Double
    
    var body: some View {
        GeometryReader { geometry in
            let radIndicatorAngle: Double = indicatorAngle * PI / 180.0
            
            let cos1: Double = cos(radIndicatorAngle + PI / 2)
            let sin1: Double = sin(radIndicatorAngle + PI / 2)
            let cos2: Double = cos(radIndicatorAngle - PI / 2)
            let sin2: Double = sin(radIndicatorAngle - PI / 2)
            
            let farCos: Double = cos(radIndicatorAngle)
            let farSin: Double = sin(radIndicatorAngle)
            
            let center = CGPoint(
                x: geometry.size.width / 2,
                y: geometry.size.height / 2
            )
            let lower = CGPoint(
                x: center.x + cos2 * innerRadius,
                y: center.y - sin2 * innerRadius
            )
            let upper = CGPoint(
                x: center.x + cos1 * innerRadius,
                y: center.y - sin1 * innerRadius
            )
            let far = CGPoint(
                x: center.x + farCos * indicatorLength,
                y: center.y - farSin * indicatorLength
            )
            
            Path { path in
                path.move(to: upper)
                path.addLine(to: lower)
                path.addLine(to: far)
            }
            .foregroundColor(color)
        }
        .frame(maxWidth: 2 * radius, maxHeight: 2 * radius)
    }
}

struct Indicator_Previews: PreviewProvider {
    
    static var previews: some View {
        Indicator(radius: 160, indicatorAngle: 0)
    }
}
