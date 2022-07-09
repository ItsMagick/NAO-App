//
//  NAOView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct NAOView: View {
    
    @State private var isShutdownPresented = false
    @State private var isDisconnectPreseted = false
    
    @ObservedObject var vm : SettingsViewModel
    
    var body: some View {
        
        
        HStack() {
            Image("NaoFace")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .leading)
            VStack(alignment: .leading) {
                HStack {
                    Text("Nao3")
                    BatteryView(vm: vm)
                        .frame(width: 50, height: 45)
                }
                
                Text(vm.nao?.ip ?? "")
                
                    
//                    CPUView(vm: vm)
//                        .frame(width: 50, height: 46.5)
                
            }
            //Button to disconnect -> Popup if you are sure about it
            VStack(spacing: 15) {
                Button("Disconnect") {
                    isDisconnectPreseted = true
                } .buttonStyle(.borderedProminent)
                    .accentColor(.red)
                    .alert(isPresented: $isDisconnectPreseted) {
                                Alert(
                                    title: Text("Are you sure you want disconnect from Nao?"),
                                    message: Text(""),
                                    primaryButton: .destructive(Text("Disconnect")) {
                                        print("Disconnecting...")
                                        NaoModelSingleton.sharedInstance.nao = nil
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                //Button to Shutdown -> Popup if you are sure about it
                Button(" Shutdown ") {
                    isShutdownPresented = true
                } .buttonStyle(.borderedProminent)
                    .accentColor(.red)
                    .alert(isPresented:$isShutdownPresented) {
                                Alert(
                                    title: Text("Are you sure you want Shutdown the Nao?"),
                                    message: Text("There is no awakening possible using only the phone"),
                                    primaryButton: .destructive(Text("Shutdown")) {
                                        print("Shutting down...")
                                        NaoModelSingleton.sharedInstance.nao = nil
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    
            }
            
            
        }
        .onAppear {
            print("Refresh")
            vm.getBatteryPercent()
        }
    }
    
    
    struct NAOView_Previews: PreviewProvider {
        static var previews: some View {
            NAOView(vm: SettingsViewModel())
        }
    }
}
