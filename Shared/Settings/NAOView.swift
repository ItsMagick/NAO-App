//
//  NAOView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct NAOView: View {
    
    var body: some View {
        
        
        HStack() {
            Image("NaoFace")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .leading)
            VStack(alignment: .leading) {
                Text(NaoModelSingleton.sharedInstance.nao?.name ?? "")
                Text(NaoModelSingleton.sharedInstance.nao?.ip ?? "")
            }
            
            
            Button("Disconnect") {
                NaoModelSingleton.sharedInstance.nao = nil
            } .buttonStyle(.borderedProminent)
                .accentColor(.red)
            
            
            
            
        }
    }
    
    
    struct NAOView_Previews: PreviewProvider {
        static var previews: some View {
            NAOView()
        }
    }
}
