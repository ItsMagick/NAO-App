//
//  ConnectNao.swift
//  NAO-App
//
//  Created by Jan Rubner on 28.06.22.
//

import SwiftUI

struct ConnectNaoView: View {
    @State var ipText: String = ""
    
    var body: some View {
        
        VStack {
            TextField("IP Adresse", text: $ipText)
                .keyboardType(.numbersAndPunctuation)
                .textFieldStyle(.roundedBorder)
                .padding()
                .frame(width: 200)
            HStack {
                Button("Fertig") {
                    let nao = NaoModel()
                    nao.name = "Jan"
                    nao.ip = ipText
                    NaoModelSingleton.sharedInstance.nao = nao
                }.buttonStyle(.borderedProminent)
                
                Button("Löschen") {
                    ipText = ""
                }.buttonStyle(.borderedProminent)
            }
            
        }
        
    }
}

struct ConnectNao_Previews: PreviewProvider {
    static var previews: some View {
        ConnectNaoView()
    }
}
