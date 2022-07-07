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
    
    
    internal func setLanguage(newLanguage : String) async {
        //diese zeile feuert fatal error, wenn man nicht mit dem now connected ist, da es diese URL nicht gibt.
        print(singleton.nao?.naoPort ?? "NoPyPort");
        print(singleton.nao?.pyPort ?? "NoPort");
        
        let url = URL(string : "http://\(singleton.nao?.getIp() ?? "No IP"):\(singleton.nao?.pyPort ?? "1234")")!
        
        
        //print(singleton.nao?.ip)
        print("url: \(url)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "language",
            "data" : [
                "language" : "\(newLanguage)"
            ],
            "naoIP" : "127.0.0.1",
            "naoPort" : "9559"
        ]
        
        let json = try? JSONSerialization.data(withJSONObject: parameters, options:[])
        print("json: \(json)")
        //let json2 = JSONEncoder.encode


        request.httpBody = json
        
         
         
/*
         let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else{
                print("error")
                return
            }
            guard(200 ... 299)~=response.statusCode else{
                return
            }
            
 do{
 let resposeObj = try JSONDecoder().decode(.self, from: data)
 
 }catch{
 print(error)
 }
 }
 */
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            //als debug-Ausgabe
            let json_test = try JSONSerialization.jsonObject(with: data, options: [])
            print(json_test)
            
            do {
                print("decode data...")
                print("response: \(response)")
                let resposeObj = try JSONDecoder().decode(NaoJSONModel.self, from: data)
                
            } catch {
                print("error decode data \(error)")
            }
            
            singleton.nao?.setLanguage(newLanguage: newLanguage)
            print(newLanguage)
            print(singleton.nao?.getLanguage() ?? "No Language Available")
        } catch {
            print("Invalid data")
        }
    }
    
    
    internal func setIp(newIp: String) {
        singleton.nao?.setIp(newIp: newIp)
    }
    
    
    internal func setVolume(newVolume: Double) {
        let url = URL(string : "http://\(getIp()):\(singleton.nao?.pyPort)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
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
        request.setValue("application/json", forHTTPHeaderField: "Accept")
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
        request.setValue("application/json", forHTTPHeaderField: "Accept")
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
