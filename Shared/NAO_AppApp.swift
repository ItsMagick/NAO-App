//
//  NAO_AppApp.swift
//  Shared
//
//  Created by Sebastian Peschke on 03.05.22.
//

import SwiftUI

@main
struct NAO_AppApp: App {
    @ObservedObject var singleton = NaoModelSingleton.sharedInstance
    
    var body: some Scene {
        WindowGroup {
            
            SplashscreenView()

        }
    }
}
