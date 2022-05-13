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
            List(functions, id: \.self) { function in
    #warning("TODO: implement subViews and popups --> No PopUps but only subViews!?")
                Text(function)
                    .font(.headline)
                
            } .navigationTitle("Functions")
        }
    }
    
}

struct MenuNavigationView_Previews: PreviewProvider {
    static var functions = ["Motion", "Speech Text", "Recorder", "Audio", "File Manager"]
    
    static var previews: some View {
        MenuNavigationView(functions: functions)
    }
}
