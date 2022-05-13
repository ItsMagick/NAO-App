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
                
                
                #warning("TODO: Vorerst eine Leere liste    Der Benutzer fügt mehr Nao's ein via IP addresse mit einem Button. Es wird folglich ein Fenster geöffnet, wo die IP addresse eingegeben wird. Die Daten werden folglich gespeichert, sodass beim Nächsten öffnen der App, die predefined Naos geladen werden kann via ein Button. Es besteht die Möglichkeit, die Daten im Nachhinein zu verändern, wie IP Addresse. Gespeicherte Daten können Manuell gelöscht werden. Jeder dieser hinzugefügte Naos besitzen einen Connect button, der schlussundendlich zum MainView führt. ")
            }
            
        
        }
        
            
            
    
}


struct FindNaoView_Previews: PreviewProvider {
    static var previews: some View {
        FindNaoView()
    }
}
