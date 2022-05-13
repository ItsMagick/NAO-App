//
//  MainView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 06.05.22.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        TabView {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            ApplicationsView()
                .tabItem {
                    Label("Apps", systemImage: "app")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        
    }
    
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

