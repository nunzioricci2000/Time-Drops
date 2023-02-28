//
//  ChimpionsApp.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 21/02/23.
//

import SwiftUI

@main
struct ChimpionsApp: App {
    // @StateObject var appModel: AppModel = AppModel()
    
    var body: some Scene {
        WindowGroup {
            PhysicsView()
                // .environmentObject(appModel)
        }
    }
}
