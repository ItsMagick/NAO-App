//
//  MenuView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 10.05.22.
//

import SwiftUI

struct MenuView: View {
    
    //dummy data
    @State var disciplines = ["Motion", "Speech Text", "Recorder", "Audio", "File Manager"]
    
    var body: some View {
        
        VStack {
            
            //placeholder for camera
            Rectangle()
                .size(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)/3)
                .padding()
            
            //MenuList
            List(disciplines, id: \.self) { discipline in
              Text(discipline)
                    .font(.headline)
            }
        }
        
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
