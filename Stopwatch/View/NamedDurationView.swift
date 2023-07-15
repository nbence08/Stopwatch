//
//  DurationView.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 07. 14..
//

import SwiftUI

struct NamedDurationView: View {
    var namedDuration: NamedDuration
    
    @State var detailsShown: Bool = false
    
    private let formatter = DateComponentsFormatter()
    
    private var duration: String {
        formatter.string(from: namedDuration.time) ?? "00:00:00"
    }
    
    init(namedDuration: NamedDuration) {
        self.namedDuration = namedDuration
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
    }
    
    var body: some View {
        Button {
            detailsShown = true
        } label: {
            HStack {
                Text(namedDuration.name)
                Spacer()
                Text(duration)
            }
            .padding()
        }
        .foregroundColor(.primary)
        .background(Color(.secondarySystemFill))
        .sheet(isPresented: $detailsShown, content: {
            VStack(alignment: .center) {
                Text(namedDuration.id)
                Text(namedDuration.name)
                Text(namedDuration.timeStamp.description)
                Text(formatter.string(for: namedDuration.time) ?? "00:00:00")
            }
        })
    }
}

struct NamedDurationView_Previews: PreviewProvider {
    static var previews: some View {
        NamedDurationView(
            namedDuration: NamedDuration(
                id: UUID().uuidString,
                name: "duration",
                time: 20.0,
                timeStamp: Date.now
            )
        )
    }
}
