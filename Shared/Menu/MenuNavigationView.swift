//
//  MenuNavigationView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 13.05.22.
//

import SwiftUI

struct MenuNavigationView: View {
    
    var functions : [String]
    var body: some View {
        NavigationView{
            List() {
                
            } .navigationTitle("Functions")
                .listStyle(.insetGrouped)
        }
    }
    
}

struct MenuNavigationView_Previews: PreviewProvider {
    static var functions = ["Motion", "Speech Text", "Audio"]
    
    static var previews: some View {
        MenuNavigationView(functions: functions)
    }
}
