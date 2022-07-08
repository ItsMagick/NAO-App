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
   
    internal func getPyPort() -> Int{
        return singleton.nao?.pyPort ?? 0000
    }
    
    internal func getNaoPort() -> Int{
        return singleton.nao?.naoPort ?? 0000
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
    
    
    
     
    internal func setLanguage2(newLanguage: String){
        Task{
            await setLanguage(newLanguage: newLanguage)
        }
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
    internal func setVolume2(newVolume: Int){
        Task{
            await setVolume(newVolume: newVolume)
            
        }
    }
    internal func setVolume(newVolume: Int) async {
        let url = URL(string : "http:\(getIp()):\(getPyPort())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "setOutputVolume",
            "data" : [
                "setOutputVolume": newVolume
            ],
            "naoIp" : "127.0.0.1",
            "naoPort" : getNaoPort()
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            
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
    internal func setAsleep2() {
        Task{
            await setAsleep()
        }
    }
    internal func setAsleep() async{
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        
        print("url: \(url)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId": 0,
                "actionId": "rest",
                "naoIp": "127.0.0.1",
                "naoPort": 9559
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
        } catch {
            print("Invalid data")
        }
    }
    internal func setAwake2() {
        Task {
            await setAwake()
        }
    }
    internal func setAwake() async{
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        
        print("url: \(url)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId": 0,
                "actionId": "wakeUp",
                "data":  [
                        "wakeUp" : true
                ],
                "naoIp": "192.168.0.248",
                "naoPort": 9559
        ]
        
        let json = try? JSONSerialization.data(withJSONObject: parameters, options:[])

        request.httpBody = json
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
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
        print("batteryData JSON starting")
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        print("currentBatteryJson:")
        //request that is being sent! WORKING
        request.httpBody = json
            
        //block does not throw an error anymore!
        do {
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
    
            //this block now throws an error -> catch error decode data
            //"The given data was not valid JSON" -> "Unable to parse empty array"
            do {
                print("decode battery data...")
                      
                _ = try JSONDecoder().decode(NaoJSONModel.self, from: data)
                
            } catch {
                print("error decode battery data \(error)")
            }
       
        } catch {
            print("Invalid data at Battery JSON")
        }
        
        #warning("TODO: decode JSON and set Int to BatteryPercent")
//        setBatteryPercent(newBatteryPercent: <#T##Int#>)
    }
    internal func getBatteryPercent2() {
        Task {
            await getBatteryPercent()
        }
    }
    internal func getCpuDegree() async {
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "cpuInfo",
            "naoIp" : "127.0.0.1",
            "naoPort" : getNaoPort()
        ]
        
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        print("start CPU JSON")
        request.httpBody = json
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                print("decode CPU data...")
                _ = try JSONDecoder().decode(NaoJSONModel.self, from: data)
                
            } catch {
                print("error decode CPU data \(error)")
            }
       
        } catch {
            print("Invalid data at CPU JSON")
        }
        #warning("TODO: decode JSON and setCpuTemp -> Int")
//        setCpuTemp(newCpuTemt: <#T##Int#>)
    }
    internal func getCpuDegree2() {
        Task {
            await getCpuDegree()
        }
    }
    
    /*
            -------------------------------- Getters -------------------------------------
     */
    internal func getCpuTemp() -> Int {
        //get data from model
        return singleton.nao?.getCpu() ?? 0
    }
    
    
    internal func getBatteryPercent() -> Int {
        Task {
            await getBatteryPercent()
        }
        
        //get data from model
        return singleton.nao?.getBattery() ?? 0
    }
    
    
    
    
    
    internal func getVolume() -> Int {
        return singleton.nao?.getVolume() ?? 0
    }
    
}
