//
//  ModelData.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 07. 10..
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var measuredTimes: [NamedDuration] = []
    
    private static func measuredTimesURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        .appendingPathComponent("measuredTimes.json")
    }
    
    func loadMeasuredTimes() async throws {
        let task = Task<[NamedDuration], Error> {
            let fileURL = try Self.measuredTimesURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let measuredTimes = try JSONDecoder().decode([NamedDuration].self, from: data)
            return measuredTimes
        }
        let measuredTimes = try await task.value
        self.measuredTimes = measuredTimes
    }
    
    func saveMeasuredTíimes() async throws {
        let task = Task {
            let fileURL = try Self.measuredTimesURL()
            let data = try JSONEncoder().encode(measuredTimes)
            try data.write(to: fileURL)
        }
        
        _ = try await task.value
    }
}

