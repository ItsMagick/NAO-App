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
    
    internal var splashHasBeenShown: Bool = false
    
    var body: some Scene {
        WindowGroup {
            
            SplashscreenView(settingsVm: SettingsViewModel.init())
//            if(singleton.nao != nil && splashHasBeenShown == false){                SplashscreenView(settingsVm: SettingsViewModel.init())
//            } else if (singleton.nao != nil) {
//                MainView(settingsVm: SettingsViewModel.init())
//            } else {
//                ConnectNaoView()
//            }
        }
    }
}
