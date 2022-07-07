//
//  MenuNavigationView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 13.05.22.
//

import SwiftUI

struct MenuNavigationView: View {
    @State var vm : MainViewModel
    @State var text:String = ""
    var functions : [String]
    var body: some View {
        NavigationView{
            List() {
                Label("Battery info: \(vm.getBatteryPercent()) %", systemImage: "").listRowSeparator(.visible)
                Label("Text-to-speech", systemImage: "").listRowSeparator(.hidden)
                TextField("Text to Speech", text: $text).onSubmit {
                    Task.init {
                            do {
                                await vm.textToSpeech(text: text)
                                text = ""
                            }
                            
                        }
                }
                
            } .navigationTitle("Functions")
                .listStyle(.insetGrouped)
        }
    
    }
    
}

struct MenuNavigationView_Previews: PreviewProvider {
    static var functions = ["Motion", "Speech Text", "Audio"]
    
    static var previews: some View {
        MenuNavigationView(vm: MainViewModel.init(), functions: functions)
    }
}
