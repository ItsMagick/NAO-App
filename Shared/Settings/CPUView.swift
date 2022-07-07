//
//  CPUView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct CPUView: View {
        
    @ObservedObject var vm : SettingsViewModel
    
    var body: some View {
        VStack() {
            
            Image(systemName: "cpu")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("\(vm.getCpuTemp())°C")
                
                .foregroundColor(vm.getCpuTemp() >= 65 ?
                    .red : .green)
//            Text("CPU Temp")
        }
    }
}

struct CPUView_Previews: PreviewProvider {
    static var previews: some View {
        CPUView(vm: SettingsViewModel.init())
    }
}
