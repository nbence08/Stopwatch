//
//  ContentView.swift
//  Stopwatch
//
//  Created by Bence Damján Nagy on 2023. 06. 15..
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var modelData: ModelData
    
    var saveAction: ()->Void

    var body: some View {
        NavigationStack{
            NavigationStack {
                NavigationLink(destination: Stopwatch()) {
                    Text("Stopwatch")
                }
            }
            .onChange(
                of: scenePhase,
                perform: { scenePhase in
                    if scenePhase == .inactive {
                        saveAction()
                    }
                }
            )
                /*.tabItem {
                    Label("Stopwatch", systemImage: "stopwatch")
                        .font(.largeTitle)
                }*/
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() {
            
        }
        .environmentObject(ModelData())
    }
}
