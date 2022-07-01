//
//  CPUView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct CPUView: View {
        
    @ObservedObject var vm = MainViewModel()
    var cpuTemp = NaoModelSingleton.sharedInstance.nao?.cpu ?? 0
    var body: some View {
        VStack() {
            
            Image(systemName: "cpu")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("\(cpuTemp)")
                .font(.largeTitle)
                .foregroundColor(cpuTemp >= 65 ?
                    .red : .green)
            Text("CPU Temp")
        }
    }
}

struct CPUView_Previews: PreviewProvider {
    static var previews: some View {
        CPUView()
    }
}
