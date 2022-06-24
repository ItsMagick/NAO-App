//
//  NAOView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct NAOView: View {
    
    var ip : String
    var body: some View {
        HStack() {
            Image("NaoFace")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .leading)
            VStack(alignment: .leading) {
                Text("Rainer Winkler")
                Text("IP: 192.168.178.42")
            }
            
            Button("Disconnect") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            } .buttonStyle(.borderedProminent)
                .accentColor(.red)
                
        }
    }
}

struct NAOView_Previews: PreviewProvider {
    static var previews: some View {
        NAOView(ip: "192.168.178.40")
    }
}
