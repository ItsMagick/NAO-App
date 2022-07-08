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
    @State private var language = 0
    @State private var languages = ["German", "English"]
    @State private var audioVolume = 1
    @State private var audioVolumes = ["0","25", "50","75", "100"]
    
    
    @ObservedObject var vm: SettingsViewModel
    
    
    var body: some View {
        
        //NAO Übersicht (Battery, CPU temp)
        NavigationView {
        VStack {
            NAOView(vm: vm)
                .padding()            
            
            List() {
                Toggle(isOn: $isAwake) {
                    Text("Rest/Wake up")
                }.onChange(of: isAwake){value in
                    if(isAwake == false){
                        vm.setAsleep()
                    }else{ vm.setAwake()}
                }
                Toggle(isOn: $autonomousLife) {
                    Text("Autonomous Life")
                }
                /*
                 Audio Volume Picker
                 */
                Picker("Audio Volume", selection: $audioVolume, content: {
                    ForEach(audioVolumes.indices) { index in
                        Text(audioVolumes[index]).tag(index)
                    }
                }).onChange(of: audioVolume){value in
                    if let volume = Int(audioVolumes[audioVolume]){
                        vm.setVolume(newVolume: Int(volume))
                        print (volume)
                    }
                }
                
                
                /*
                 Language Picker
                 */
                Picker("Language", selection: $language, content: {
                    ForEach (languages.indices) { index in
                        Text(languages[index]).tag(index)
                    }
                }).pickerStyle(.inline)
                    .onChange(of: language){ value in
                    //vm.setLanguage(newLanguage: languages[language])
                        
                                    //TODO: German dynamisch füllen
                                    vm.setLanguage(newLanguage: languages[value])
                               
                                
                        }
                        
                    
                    
            }
            
            
        }.navigationTitle("Settings")
        
        }
        .onAppear {
            vm.getBatteryPercent()
        }
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(vm: SettingsViewModel.init())
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
