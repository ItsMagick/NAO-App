//
//  SettingsViewModel.swift
//  NAO-App
//
//  Created by Jan Rubner on 28.06.22.
//

import Foundation
import Combine

@MainActor class SettingsViewModel : ObservableObject {
    var mainVM:MainViewModel = MainViewModel.init()
    @Published var didChange = true
    fileprivate let singleton = NaoModelSingleton.sharedInstance
    fileprivate var subscription : AnyCancellable!
    
    init() {
        
//        subscription = SettingsViewModel().modelNotifier().sink{
//            self.didChange.toggle()
//        }
        Task {
            await fetchData()
        }
    }
    
    func modelNotifier() -> ObservableObjectPublisher {
        return singleton.objectWillChange
    }
    
    
    internal func fetchData() async {
        setBatteryPercent(newBatteryPercent: mainVM.getBattery())
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
        
        //diese zeile feuert fatal error, wenn man nicht mit dem now connected ist, da es diese URL nicht gibt.
        let url = URL(string : "http://\(singleton.nao?.getIp()):\(singleton.nao?.pyPort)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "tts",
            "data" : [
                "language" : "\(newLanguage)"
            ],
            "naoIP" : "\(singleton.nao?.getIp())",
            "naoPort" : "\(singleton.nao?.naoPort)"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
        
        singleton.nao?.setLanguage(newLanguage: newLanguage)
    }
    
    
    
    internal func setIp(newIp: String) {
        singleton.nao?.setIp(newIp: newIp)
    }
    
    
    internal func setVolume(newVolume: Double) {
        let url = URL(string : "http://\(getIp()):\(singleton.nao?.pyPort)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "setMaxVolume",
            "data" : [
                "setMaxVolume": "\(newVolume)"
            ],
            "naoIP" : "\(getIp())",
            "naoPort" : "\(singleton.nao?.naoPort)"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
        
        singleton.nao?.setVolume(newVolume: newVolume)
    }
    
    func setAsleep(){
        let url = URL(string : "http://\(getIp()):\(singleton.nao?.pyPort)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "rest",
            "naoIP" : "\(getIp())",
            "naoPort" : "\(singleton.nao?.naoPort)"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
    }
    
    func setAwake(){
        let url = URL(string : "http://\(getIp()):\(singleton.nao?.pyPort)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "wakeUp",
            "data" : [
                "wakeUp" : true
            ],
            "naoIP" : "\(getIp())",
            "naoPort" : "\(singleton.nao?.naoPort)"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
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
