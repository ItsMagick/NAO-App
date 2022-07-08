//
//  SettingsViewModel.swift
//  NAO-App
//
//  Created by Jan Rubner on 28.06.22.
//

import Foundation
import Combine

@MainActor
class SettingsViewModel : ObservableObject {
    
    var network = NetworkLayer()
    
    @Published var didChange = true
    fileprivate let singleton = NaoModelSingleton.sharedInstance
    fileprivate var subscription : AnyCancellable!
    
    init() {
        
        subscription = self.modelNotifier().sink {
            self.didChange.toggle()
        }
        
    }
    
    
    internal func modelNotifier() -> ObservableObjectPublisher {
        return singleton.objectWillChange
    }
    
    /*
     ---------------------------------- Model Getters -----------------------------------
     */
    internal func getIp() -> String {
        return singleton.nao?.getIp() ?? "N.A"
    }
    
    internal func setIp(newIp: String) {
        singleton.nao?.setIp(newIp: newIp)
    }
    
    
    
    
    /*
            --------------------------- Setters With API ---------------------------------
     */
    internal func setBatteryPercent(newBatteryPercent: Int) {
        singleton.nao?.setBattery(batteryPercent: newBatteryPercent)
    }
    internal func setCpuTemp(newCpuTemt: Int) {
        singleton.nao?.setCpu(cpuDegree: newCpuTemt)
    }
    
    
    
    
    /*
            ----------------------- Network/API Layer getters/setter ---------------------
     */
    internal func getCpuTemp() -> Int {
        NetworkLayer.init()
        //get data from model
        return singleton.nao?.getCpu() ?? 0
    }
    
    internal func getBatteryPercent() -> Int {
        NetworkLayer.init()
        //get data from model
        return singleton.nao?.getBattery() ?? 0
    }
    
    internal func setAsleep() {
        NetworkLayer().setAsleep()
    }
    
    internal func setAwake() {
        NetworkLayer().setAwake()
    }
    
    internal func setVolume(newVolume: Int) {
        NetworkLayer().setVolume(newVolume: newVolume)
    }
    
    internal func setLanguage(newLanguage: String) {
        NetworkLayer().setLanguage(newLanguage: newLanguage)
    }
    
}
