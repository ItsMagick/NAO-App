//
//  MenuView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 10.05.22.
//

import SwiftUI

struct MenuView: View {
    @State var vm : MainViewModel
    //dummy data
    @State var functions = ["Camera" , "Motion", "Speech Text", "Recorder", "Audio", "File Manager"]
    #warning("TODO: implement API calls and add List showing what can be done in the Functions Tab")
    
    var body: some View {
        Button("Battery Info"){
            vm.getBattery()
            print("adkad")
        }
        //MenuList
        MenuNavigationView(functions: functions)
        
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(vm: MainViewModel.init())
    }
}


