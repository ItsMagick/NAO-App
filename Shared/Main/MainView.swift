//
//  MainView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 06.05.22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var settingsVm = SettingsViewModel.init()
    @ObservedObject var mainVm = MainViewModel.init()
    
    var body: some View {
        //TabView Switching between MenuView, ApplicationView, SettingsViewA
        TabView {
            MenuView(vm: mainVm)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            SettingsView(vm: settingsVm)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        #warning("TODO: UI für die Funktionalitäten.")
        
    }
    
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(settingsVm: SettingsViewModel.init())
    }
}

