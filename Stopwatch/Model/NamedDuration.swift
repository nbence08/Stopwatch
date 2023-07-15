//
//  NamedTime.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 07. 10..
//

import Foundation

struct NamedDuration: Identifiable, Codable {
    let id: String  //guid
    
    let name: String
    let time: TimeInterval
    let timeStamp: Date
}
