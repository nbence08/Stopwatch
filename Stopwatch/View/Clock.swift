//
//  Clock.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 07. 01..
//

import SwiftUI

struct Clock: View {
    var radius: Double = 150.0
    
    @Binding var seconds: Double
    @Binding var minutes: Double
    @Binding var hours: Double
    
    var body: some View {
        ZStack {
            TickedCircle(radius: radius)
                
            Indicator(
                radius: radius,
                innerRadius: 3,
                indicatorLength: radius,
                color: .accentColor,
                indicatorAngle: -6 * seconds + 90
            )
            .zIndex(0)
            
            Indicator(
                radius: radius,
                innerRadius: 5,
                indicatorLength: radius * 7/8,
                color: .primary,
                indicatorAngle: -6 * minutes + 90
            )
            .zIndex(1)
            
            Indicator(
                radius: radius,
                innerRadius: 7,
                indicatorLength: radius / 2,
                color: .secondary,
                indicatorAngle: -15 * hours + 90 - minutes / 2
            )
            .zIndex(2)

            Circle()
                .frame(width: 14)
                .foregroundColor(.primary)
        }
    }
}

struct Clock_Previews: PreviewProvider {
    @State static var secIndicatorAngle: Double = 25
    @State static var minIndicatorAngle: Double = 270
    @State static var hrIndicatorAngle: Double = 285

    static var previews: some View {
        Clock(seconds: $secIndicatorAngle, minutes: $minIndicatorAngle, hours: $hrIndicatorAngle)
    }
}
