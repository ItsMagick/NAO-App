//
//  MenuView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 10.05.22.
//

import SwiftUI

struct FunctionsView: View {
    
    @State var vm: MainViewModel
    
    var body: some View {
        
        MenuNavigationView(vm: MainViewModel.init())
        
    }
        
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionsView(vm: MainViewModel.init())
    }
}


