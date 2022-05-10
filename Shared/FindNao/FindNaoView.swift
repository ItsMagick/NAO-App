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
        VStack{
                
            NavigationView{
                List(naoData, id: \.self){ nao in
                    Text(nao)
                    
                }.navigationTitle("NAO")
            }
        
            HStack{
                Button("Refresh") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                
                Button("Enter Custom IP") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                
            }
        }
        
            
            
    
    }
}

struct FindNaoView_Previews: PreviewProvider {
    static var previews: some View {
        FindNaoView()
    }
}
