//
//  FindNaoView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 06.05.22.
//

import SwiftUI

struct FindNaoView: View {
    
    var naoData = ["Nao", "Nao2", "Nao3", "Nao4", "Nao5", "Nao6"]
    
    var body: some View {
        
            NavigationView{
                
                List(naoData, id: \.self) { nao in
                    Text(nao)
                }.navigationTitle("Nao Liste")
                    
            }
            
        
        }
        
            
            
    
}


struct FindNaoView_Previews: PreviewProvider {
    static var previews: some View {
        FindNaoView()
    }
}
