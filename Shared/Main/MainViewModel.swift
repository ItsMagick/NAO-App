//
//  MainViewModel.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 01.07.22.
//

import Foundation
import Combine

class MainViewModel : ObservableObject {
    
    fileprivate let singleton = NaoModelSingleton.sharedInstance

    init() {
        
    }
    /*
        IP
     */

    
    
    
    
    /*
        ####################Setter&Getter##########################
     */
    ///sends Ip to Model and sets it there
    internal func setIp(userInputString: String) {
        singleton.nao?.setIp(newIp: userInputString)
    }
    ///gets ip from model
    internal func getIp() -> String {
        return singleton.nao?.getIp() ?? ""
    }
    /*
        Battery
     */
    ///gets Battery from Model
    internal func getBatteryPercent() -> Int {
        return singleton.nao?.getBattery() ?? 0
    }
    ///sets Battery to model
    internal func setBatteryPercent(newBatteryPercent: Int) {
        singleton.nao?.setBattery(batteryPercent: newBatteryPercent)
    }
    
    /*
        Volume
     */
    ///sets Volume to Model
    internal func setVolume(newVolume: Double) {
        singleton.nao?.setVolume(newVolume: newVolume)
    }
    ///gets Volume from Model
    internal func getVolume() -> Double {
        return singleton.nao?.getVolume() ?? 0.0
    }
    
    /*
        name
     */
    ///gets name from Model
    internal func getName() -> String {
        return singleton.nao?.getName() ?? ""
    }
    /*
        CPUTemp
     */
    ///gets CPUTemp from Model
    internal func getCpuTemp() -> Int {
        return singleton.nao?.getCpu() ?? 0
    }
    ///sets CPUTemp to Model
    internal func setCpuTemp(newCpuTemp: Int) {
        singleton.nao?.setCpu(cpuDegree: newCpuTemp)
    }
    /*
        Language
     */
    ///sets language to Model
    internal func setLanguage(newLanguage: String) {
        singleton.nao?.setLanguage(newLanguage: newLanguage)
    }
    ///gets language from Model
    internal func getLanguage() -> String {
        return singleton.nao?.getLanguage() ?? ""
    }
    
    internal func getBattery(){
        let url = URL(string : "http://\(getIp()):\(port)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "" : ""
            "" : ""
        ]
        
        
    }
    
    
    
}
