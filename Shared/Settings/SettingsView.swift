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
//            HStack(spacing: 20) {
//                Spacer()
//                BatteryView(vm: vm)
//                    .frame(width: 50, height: 50)
//                    
//                Spacer()
//                
//                CPUView(vm: vm)
//                    .frame(width: 50, height: 50)
//                    
//                Spacer()
//            }
            
            
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
                    if let volume = Double(audioVolumes[audioVolume]){

                        //vm.setVolume(newVolume: volume/100)

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
                        Task.init() {
                                do {

                                    //TODO: German dynamisch füllen
                                    //await vm.setLanguage(newLanguage: languages[value])
                                }catch {
                                    /// To define error behavour
                                }
                                
                            }
                        
                    }
                    
            }
            
            
        }.navigationTitle("Settings")
        
        }
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(vm: SettingsViewModel.init())
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
