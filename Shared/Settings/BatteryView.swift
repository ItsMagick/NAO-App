//
//  BatteryView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct BatteryView: View {
    
    @ObservedObject var vm : SettingsViewModel
    
    
    var body: some View {
        HStack() {
            checkBatteryIcon(batteryPercent: vm.getBatteryPercent())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            Text("\(vm.getBatteryPercent())")
                .foregroundColor(vm.getBatteryPercent() <= 30 ?
                    .red : .green)
//            Text("Battery")
            
            
        }
        
    }
    
    
    func checkBatteryIcon(batteryPercent: Int) -> Image {
        switch batteryPercent {
        case 0...40:
            return Image(systemName: "battery.25")
        case 41...65:
            return Image(systemName: "battery.50")
        case 66...80:
            return Image(systemName: "battery.75")
        case 81...100:
            return Image(systemName: "battery.100")
        default:
            return Image(systemName: "battery.0")
        }
    }
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryView(vm: SettingsViewModel.init())
    }
}
