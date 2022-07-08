//
//  MenuView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 10.05.22.
//

import SwiftUI

struct FunctionsView: View {
    @State var vm: MainViewModel
    //dummy data
    @State var functions = ["Camera" , "Motion", "Speech Text", "Recorder", "Audio", "File Manager"]
    
    var body: some View {
       
        //MenuList
        
        MenuNavigationView(vm: MainViewModel.init(), functions: functions)
        
        
    }
        
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionsView(vm: MainViewModel.init())
    }
}


