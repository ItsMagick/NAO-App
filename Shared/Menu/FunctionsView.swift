//
//  MenuView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 10.05.22.
//

import SwiftUI

struct FunctionsView: View {
    
    @StateObject var vm = MainViewModel()

    var body: some View {
        
        MenuNavigationView(vm: vm)
        
    }
        
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionsView(vm: MainViewModel.init())
    }
}


