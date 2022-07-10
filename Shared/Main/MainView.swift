//
//  MainView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 06.05.22.
//

import SwiftUI

struct MainView: View {
    
    
    var body: some View {
        //TabView Switching between MenuView, ApplicationView, SettingsViewA
        TabView {
            SettingsView()
                .tabItem {
                    Label("Overview", systemImage: "gearshape")
                }
            FunctionsView()
                .tabItem {
                    Label("Functions", systemImage: "list.dash")
                }
            
        }
        
    }
    
}


//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(settingsVm: SettingsViewModel.init())
//    }
//}

