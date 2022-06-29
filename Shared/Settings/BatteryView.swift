//
//  BatteryView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct BatteryView: View {
    
    var batteryPercent = NaoModelSingleton.sharedInstance.nao?.battery ?? 0
    
    var body: some View {
        VStack() {
            checkBatteryIcon()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            Text("\(batteryPercent)")
                .font(.largeTitle)
                .foregroundColor(batteryPercent <= 30 ?
                    .red : .green)
            Text("Battery")
        }
        
    }
    
    
    func checkBatteryIcon() -> Image {
        switch batteryPercent  {
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
        BatteryView()
    }
}
