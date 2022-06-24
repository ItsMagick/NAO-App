//
//  SettingsView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 10.05.22.
//

import SwiftUI

struct SettingsView: View {
    
    @State var isAwake : Bool = true
    @State var autonomousLife : Bool = true
    var ip : String = "192.168.178.41"
    @State private var language = 0
    @State private var languages = ["German", "English"]
    
    @State private var volume = 1
    @State private var volumes = ["0","25","50", "75", "100"]
    
    var body: some View {
        
        //NAO Übersicht (Battery, CPU temp)
        VStack {
            NAOView(ip: ip)
            HStack(spacing: 20) {
                
                BatteryView(batteryPercent: 50)
                    .frame(width: 150, height: 150)
                    
                    
                Divider()
                
                CPUView(cpuTemp: 57)
                    .frame(width: 150, height: 150)
            }
            
            NavigationView {
            List() {
                Toggle(isOn: $isAwake) {
                    Text("Rest/Wake up")
                }
                Toggle(isOn: $autonomousLife) {
                    Text("Autonomous Life")
                }
                
                
                Picker("Speech Volume", selection: $volume, content: {
                    ForEach(volumes.indices) {index in
                        Text(volumes[index]).tag(index)
                    }
                }).pickerStyle(SegmentedPickerStyle())
                Picker("Speech language", selection: $language, content: {
                    ForEach (languages.indices) { index in
                        Text(languages[index]).tag(index)
                    }
                    
                    
                }).pickerStyle(.inline)
            }
            HStack() {
                Button("Reboot") {
                    //reboot code
                }.buttonStyle(.borderedProminent)
                
                Button("Shutdown") {
                    //shutdown code
                }.buttonStyle(.borderedProminent)
                
            }.padding()
                
            }.navigationTitle("Test")
            
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isAwake: true)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
