//
//  SettingsViewModel.swift
//  NAO-App
//
//  Created by Jan Rubner on 28.06.22.
//

import Foundation
import Combine

@MainActor class SettingsViewModel : ObservableObject {
    
    init() {
        Task {
            await fetchData()
        }
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
        NaoModelSingleton.sharedInstance.nao?.setBattery(batteryPercent: newBatteryPercent)
    }
    internal func setCpuTemp(newCpuTemt: Int) {
        NaoModelSingleton.sharedInstance.nao?.setCpu(cpuDegree: newCpuTemt)
    }
    internal func setLanguage(newLanguage : String) async {
        #warning("TODO: API request to set language, if response 200 -> code below")
        NaoModelSingleton.sharedInstance.nao?.setLanguage(newLanguage: newLanguage)
    }
    
    /*
            ##########################Getters###########################
     */
    internal func getCpuTemp() async -> Int {
        //get data from model
        return NaoModelSingleton.sharedInstance.nao?.getCpu() ?? 0
    }
    internal func getBatteryPercent() async -> Int {
        //get data from model
        return NaoModelSingleton.sharedInstance.nao?.getBattery() ?? 0
    }
    
   
    
    
}
