//
//  MenuView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 10.05.22.
//

import SwiftUI

struct MenuView: View {
    
    //dummy data
    @State var functions = ["Motion", "Speech Text", "Recorder", "Audio", "File Manager"]
    #warning("TODO: implement API calls and Models")
    
    var body: some View {
        
        VStack {
            
            //placeholder for camera
            Rectangle()
                .size(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)/3)
                .padding()
            
            //MenuList
            NavigationView{
                List(functions, id: \.self) { function in
                    #warning("TODO: implement subViews and popups")
                  Text(function)
                        .font(.headline)
                        
                } .navigationTitle("Functions")
            }
            
        }
        
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
