//
//  ChimpionsApp.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 21/02/23.
//

import SwiftUI

@main
struct ChimpionsApp: App {
    @StateObject var persistency = PersistencyManager.preview
    
    var body: some Scene {
        WindowGroup {
            MainViewFlow()
                .environmentObject(persistency)
        }
    }
}
