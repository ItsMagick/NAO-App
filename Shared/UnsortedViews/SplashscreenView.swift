//
//  SplashscreenView.swift
//  NAO-App
//
//  Created by Jan Rubner on 29.06.22.
//

import SwiftUI

struct SplashscreenView: View {
    
    @ObservedObject var settingsVm : SettingsViewModel
    @ObservedObject var singleton = NaoModelSingleton.sharedInstance


    
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            // 2.
            if self.isActive {
                if(singleton.nao != nil) {
                    MainView(settingsVm: settingsVm)
                } else {
                    ConnectNaoView()
                }
            } else {
                
                VStack() {
                    Image("SplashScreenTop")
                        .resizable()
                        .padding()
                    Spacer()
                    Text("Gamma Studios")
                        .font(Font.largeTitle)
                        
                    Spacer()
                    Image("SplashScreenBottom")
                        .resizable()
                        .padding()
                }
                
                
                
                
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}

//struct SplashscreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashscreenView()
//    }
//}
