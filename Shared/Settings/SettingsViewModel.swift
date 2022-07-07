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
    var mainVM:MainViewModel = MainViewModel.init()
    @Published var didChange = true
    fileprivate let singleton = NaoModelSingleton.sharedInstance
    fileprivate var subscription : AnyCancellable!
    
    init() {
        
        subscription = self.modelNotifier().sink {
            self.didChange.toggle()
        }
        
        Task {
            print("before fetch")
            await fetchData()
            print("after fetch")
            print(singleton.nao?.getBattery())
        }
    }
    
    internal func setLanguage2(newLanguage: String){
        Task{
            await setLanguage(newLanguage: newLanguage)
        }
    }
    
    internal func fetchData() async {
        
        await setBatteryPercent(newBatteryPercent: mainVM.getBattery())
        //setCpuTemp()
    }
    
    func modelNotifier() -> ObservableObjectPublisher {
        return singleton.objectWillChange
    }
    
    /*
     ---------------------------------- Model Getters -----------------------------------
     */
    internal func getIp() -> String {
        return singleton.nao?.getIp() ?? "N.A"
    }
   
    func getPyPort() -> Int{
        return singleton.nao?.pyPort ?? 0000
    }
    
    func getNaoPort() -> Int{
        return singleton.nao?.naoPort ?? 0000
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
    
    
    internal func setLanguage(newLanguage : String) async {

        
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        
        print("url: \(url)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "language",
            "data" : [
                "language" : "\(newLanguage)"
            ],
            "naoIp" : "127.0.0.1",
            "naoPort" : getNaoPort()
        ]
        
        let json = try? JSONSerialization.data(withJSONObject: parameters, options:[])

        request.httpBody = json
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            //als debug-Ausgabe
            let json_test = try JSONSerialization.jsonObject(with: data, options: [])
            print(json_test)
            
            do {
                print("decode data...")
                print("response: \(response)")
                _ = try JSONDecoder().decode(NaoJSONModel.self, from: data)
                
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
    
    /*
    internal func setIp(newIp: String) {
        singleton.nao?.setIp(newIp: newIp)
    }
     */
    
    
    internal func setVolume(newVolume: Double) async {
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "setMaxVolume",
            "data" : [
                "setMaxVolume": "\(newVolume)"
            ],
            "naoIp" : "127.0.0.1",
            "naoPort" : getNaoPort()
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            //als debug-Ausgabe
            let json_test = try JSONSerialization.jsonObject(with: data, options: [])
            print(json_test)
            
            do {
                print("decode data...")
                print("response: \(response)")
                _ = try JSONDecoder().decode(NaoJSONModel.self, from: data)
                
            } catch {
                print("error decode data \(error)")
            }
       
        } catch {
            print("Invalid data")
        }
        
        singleton.nao?.setVolume(newVolume: newVolume)
    }
    
    func setAsleep(){
        let url = URL(string : "http://\(getIp()):\(getPyPort)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "rest",
            "naoIp" : "127.0.0.1",
            "naoPort" : getNaoPort()
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
    }
    
    func setAwake(){
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "wakeUp",
            "data" : [
                "wakeUp" : true
            ],
            "naoIp" : "127.0.0.1",
            "naoPort" : getNaoPort()
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
    }
    internal func getBatteryPercent() async{
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "batteryInfo",
            "naoIp" : "127.0.0.1",
            "naoPort" : getNaoPort()
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            //als debug-Ausgabe
            let json_test = try JSONSerialization.jsonObject(with: data, options: [])
            print(json_test)
            
            do {
                print("decode data...")
                print("response: \(response)")
                _ = try JSONDecoder().decode(NaoJSONModel.self, from: data)
                
            } catch {
                print("error decode data \(error)")
            }
       
        } catch {
            print("Invalid data")
        }
        
       // singleton.nao?.setBattery(batteryPercent: <#T##Int#>))
    }
    
    /*
            -------------------------------- Getters -------------------------------------
     */
    internal func getCpuTemp() -> Int {
        //get data from model
        return singleton.nao?.getCpu() ?? 0
    }
    
    
    internal func getBatteryPercent() -> Int {
        
        //get data from model
        return singleton.nao?.getBattery() ?? 0
    }
    
    
    
    
    
    internal func getVolume() -> Double {
        return singleton.nao?.getVolume() ?? 0.0
    }
    
}
