//
//  SettingsViewModel.swift
//  NAO-App
//
//  Created by Jan Rubner on 28.06.22.
//

import SwiftUI
import Combine


class SettingsViewModel : ObservableObject {
    
    @State var nao = NaoModelSingleton.sharedInstance.nao
    
    var network = NetworkLayer()
    
    fileprivate let singleton = NaoModelSingleton.sharedInstance
    
    
    internal func modelNotifier() -> ObservableObjectPublisher {
        return singleton.objectWillChange
    }
    
    /*
     ---------------------------------- Model Getters -----------------------------------
     */
    internal func getIp() -> String {
        return nao?.getIp() ?? "N.A"
    }
    
    internal func setIp(newIp: String) {
        nao?.setIp(newIp: newIp)
    }
    
    
    
    
    /*
     --------------------------- Setters With API ---------------------------------
     */
    internal func setBatteryPercent(newBatteryPercent: Int) {
        nao?.setBattery(batteryPercent: newBatteryPercent)
    }
    internal func setCpuTemp(newCpuTemt: Int) {
        nao?.setCpu(cpuDegree: newCpuTemt)
    }
    
    
    
    
    /*
     ----------------------- Network/API Layer getters/setter ---------------------
     */
    internal func getCpuTemp() -> Int {
        //network.get
        //get data from model
        return nao?.getCpu() ?? 0
    }
    
    internal func getBatteryPercent() {
        network.getBatteryFromNao()
        //get data from model
    }
    
    internal func setAsleep() {
        network.setAsleep()
    }
    
    internal func setAwake() {
        network.setAwake()
    }
    
    internal func setVolume(newVolume: Int) {
        network.setVolume(newVolume: newVolume)
    }
    
    internal func setLanguage(newLanguage: String) {
        network.setLanguage(newLanguage: newLanguage)
    }
    
}


