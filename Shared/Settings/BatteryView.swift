//
//  BatteryView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct BatteryView: View {
#warning("TODO: observ and publish to batteryPercent")
    var batteryPercent: Float = 0
    
    var body: some View {
#warning("TODO: add View to add to the SettingsView")
        checkBatteryIcon()
                .resizable()
                .aspectRatio(contentMode: .fit)
    }
    
    
    func checkBatteryIcon() -> Image {
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
        BatteryView(batteryPercent: 25)
    }
}
