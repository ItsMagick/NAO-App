//
//  SettingsViewModel.swift
//  NAO-App
//
//  Created by Jan Rubner on 28.06.22.
//

import Foundation
import Combine

@MainActor class SettingsViewModel : ObservableObject {
    
    @Published var didChange = true
    fileprivate let singleton = NaoModelSingleton.sharedInstance
    fileprivate var subscription : AnyCancellable!
    
    init() {
        
        subscription = SettingsViewModel().modelNotifier().sink{
            self.didChange.toggle()
        }
        Task {
            await fetchData()
        }
    }
    
    func modelNotifier() -> ObservableObjectPublisher {
        return singleton.objectWillChange
    }
    
    
    internal func fetchData() async {
        #warning("TODO: API call, add data to NaoModel with given setters")
        //setBatteryPercent()
        //setCpuTemp()
    }
    
    /*
            ##########################Setters###########################
     */
    internal func setBatteryPercent(newBatteryPercent: Int) {
        singleton.nao?.setBattery(batteryPercent: newBatteryPercent)
    }
    internal func setCpuTemp(newCpuTemt: Int) {
        singleton.nao?.setCpu(cpuDegree: newCpuTemt)
    }
    internal func setLanguage(newLanguage : String) {
        #warning("TODO: API request to set language, if response 200 -> code below")
        singleton.nao?.setLanguage(newLanguage: newLanguage)
    }
    
    internal func setIp(newIp: String) {
        singleton.nao?.setIp(newIp: newIp)
    }
    internal func setVolume(newVolume: Double) {
        singleton.nao?.setVolume(newVolume: newVolume)
    }
    
    /*
            ##########################Getters###########################
     */
    internal func getCpuTemp() -> Int {
        //get data from model
        return singleton.nao?.getCpu() ?? 0
    }
    internal func getBatteryPercent() -> Int {
        //get data from model
        return singleton.nao?.getBattery() ?? 0
    }
    internal func getIp() -> String {
        return singleton.nao?.getIp() ?? "N.A"
    }
    internal func getVolume() -> Double {
        return singleton.nao?.getVolume() ?? 0.0
    }
    
    
    
   
    
    
}
