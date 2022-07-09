//
//  CPUView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct CPUView: View {
    //currently not working since there is no endpoint
    @State var cpu : Int
    
    var body: some View {
        VStack() {
            
            Image(systemName: "cpu")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("\(cpu)°C")
                
                .foregroundColor(cpu >= 65 ?
                    .red : .green)
//            Text("CPU Temp")
        }
    }
}

struct CPUView_Previews: PreviewProvider {
    static var previews: some View {
        CPUView(cpu: 35)
    }
}
