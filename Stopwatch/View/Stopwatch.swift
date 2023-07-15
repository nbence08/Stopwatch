//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 06. 30..
//

import SwiftUI
import Dispatch

func structureTimeInterval(timeInterval: TimeInterval) -> (Int, Int, Int) {
    let seconds: Int = Int(timeInterval)
    let minutes = seconds / 60
    let hours = minutes / 60
    let truncatedSeconds = seconds % 60
    return (Int(truncatedSeconds), minutes, Int(hours))
}

struct Stopwatch: View {
    @State var startTime: Date = Date.now
    
    @State var seconds: Double = 0
    @State var minutes: Double = 0
    @State var hours: Double = 0
    
    @State var counting: Bool = false
    
    @State var counterString: String = "00:00:00"
    
    @EnvironmentObject var modelData: ModelData
        
    private let formatter = DateComponentsFormatter()
    
    func updateTimerRecursively() {
        let updateTimerRecursivelyClosure = {
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.zeroFormattingBehavior = .pad
            
            let (seconds, minutes, hours) = structureTimeInterval(timeInterval: Date.now.timeIntervalSince(startTime))
            self.seconds = Double(seconds)
            self.minutes = Double(minutes)
            self.hours = Double(hours)
            
            counterString = formatter.string(from: startTime, to: Date.now)!
            if counting {
                updateTimerRecursively()
            } else {
                modelData.measuredTimes.append(
                    NamedDuration(
                        id: UUID().uuidString,
                        name: "measuredTime #\(modelData.measuredTimes.count)",
                        time: Date.now.timeIntervalSince(startTime),
                        timeStamp: Date.now
                    )
                )
                modelData.objectWillChange.send()
            }
        }
        DispatchQueue.global(qos: .userInteractive).async (execute: updateTimerRecursivelyClosure)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            /*Text("Stopwatch")
                .font(.title)
                .padding(.top)
                .padding(.bottom, 60)*/
            Text(counterString)
                .font(.system(size: 30))
            Clock(
                radius: 150,
                seconds: $seconds,
                minutes: $minutes,
                hours: $hours
            )
            .padding(.bottom)
            
            Divider()
            
            ScrollView {
                ForEach (modelData.measuredTimes) { namedDuration in
                    NamedDurationView(namedDuration: namedDuration)
                }
            }
            
            Spacer()
            .scaledToFit()
            
            if(!counting) {
                Button("START", action: {
                    self.counting = true
                    startTime = Date.now
                    DispatchQueue.global(qos: .userInteractive).async (execute: updateTimerRecursively)
                })
                .buttonStyle(.borderedProminent)
            } else {
                Button("STOP", action: {
                    self.counting = false
                })
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
        }
        .navigationTitle("Stopwatch")
        //.navigationBarTitleDisplayMode(.inline)
    }
}

struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        Stopwatch()
            .environmentObject(ModelData())
    }
}
