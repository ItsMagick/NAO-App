//
//  SettingsView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 10.05.22.
//

import SwiftUI

struct SettingsView: View {
    
    var settingsItems = ["Rest/Wake Up", "Audio Volume", "Speech Volume", "Speech Language", "Autonomous Life", "System Reboot"]
    var body: some View {
        
        //NAO Übersicht (Battery, CPU temp)
        VStack {
            NAOView()
            HStack() {
                BatteryView(batteryPercent: 50)
                    .frame(width: 100)
                CPUView()
            }
            
            List(settingsItems, id: \.self) { string in
                Text(string)
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
