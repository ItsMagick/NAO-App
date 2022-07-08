//
//  NetworkLayer.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 08.07.22.
//

import Foundation
import UIKit

internal class NetworkLayer : ObservableObject {
    
    fileprivate var iP = "192.168.171.148"
    fileprivate var pyPort = 8283
    fileprivate var naoPort = 9559
    
    init() {
        Task {
            await getBatteryFromNao()
            //await getCpuDegree()
        }
    }
    
    /*
        Battery
     */
    internal func getBatteryFromNao() async {
        
        guard let url = URL(string : "http://\(iP):\(pyPort)")
        else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "batteryInfo",
            "naoIp" : "127.0.0.1",
            "naoPort" : naoPort
        ]
        print("batteryData JSON starting")
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        //request that is being sent! WORKING
        request.httpBody = json
            
        //block does not throw an error anymore!
        do {
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
    
            //this block now throws an error -> catch error decode data
            //"The given data was not valid JSON" -> "Unable to parse empty array"
            do {
                print("decode battery data...")
                      
                let batteryObject : NaoJSONModel = try JSONDecoder().decode(NaoJSONModel.self, from: data)
                print("BatteryInfo: \(batteryObject.data?.batteryInfo)")
                setBatteryPercent(newPercent: batteryObject.data?.batteryInfo ?? 0)
                
            } catch {
                print("error decode battery data \(error)")
            }
       
        } catch {
            print("Invalid data at Battery JSON")
        }
        
    }
    internal func setBatteryPercent(newPercent: Int) {
        NaoModelSingleton.sharedInstance.nao?.setBattery(batteryPercent: newPercent)
    }
    /*
        CPU
     */
    internal func getCpuDegree() async {
        guard let url = URL(string : "http://\(iP):\(pyPort)")
        else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "cpuInfo",
            "naoIp" : "127.0.0.1",
            "naoPort" : naoPort
        ]
        
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        print("start CPU JSON")
        request.httpBody = json
        
        do {
            //implement cpuDegreeApiCall here if possible from Server
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
    internal func setcpuDegree(newDegree: Int) {
        NaoModelSingleton.sharedInstance.nao?.setCpu(cpuDegree: newDegree)
    }
    /*
        Awake/Rest
     */
    internal func setAwake() {
        Task {
            await setAwake()
        }
    }
    internal func setAwake() async {
        let url = URL(string : "http://\(iP):\(pyPort)")!
        
        print("url: \(url)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId": 0,
                "actionId": "wakeUp",
                "naoIp": "127.0.0.1",
                "naoPort": naoPort
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
    internal func setAsleep() {
        Task {
            await setAsleep()
        }
    }
    internal func setAsleep() async{
        guard let url = URL(string : "http://\(iP):\(pyPort)")
        else{
            return
        }
        
        print("url: \(url)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId": 0,
                "actionId": "rest",
                "naoIp": "127.0.0.1",
                "naoPort": naoPort
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
    /*
        Volume
     */
    internal func setVolume(newVolume: Int) {
        Task {
            await setVolume(newVolume: newVolume)
        }
    }
    internal func setVolume(newVolume: Int) async {
        let url = URL(string : "http:\(iP):\(pyPort)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "setOutputVolume",
            "data" : [
                "setOutputVolume": newVolume
            ],
            "naoIp" : "127.0.0.1",
            "naoPort" : naoPort
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
        
        NaoModelSingleton.sharedInstance.nao?.setVolume(newVolume: newVolume)
    }
    /*
        Language
     */
    internal func setLanguage(newLanguage: String) {
        Task {
            await setLanguage(newLanguage: newLanguage)
        }
    }
    internal func setLanguage(newLanguage : String) async {

        
        let url = URL(string : "http://\(iP):\(pyPort)")!
        
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
            "naoPort" : naoPort
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
            NaoModelSingleton.sharedInstance.nao?.setLanguage(newLanguage: newLanguage)
        } catch {
            print("Invalid data")
        }
    }
}
