//
//  StopwatchApp.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 06. 15..
//

import SwiftUI

@main
struct StopwatchApp: App {
    @StateObject private var modelData: ModelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView() {
                Task {
                    do {
                        try await modelData.saveMeasuredTimes()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(modelData)
            .task {
                do {
                    try await modelData.loadMeasuredTimes()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
