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
        --------------------- Setter&Getter ---------------------------
     */
    
    internal func getPyPort() -> Int{
        return singleton.nao?.pyPort ?? 0000
    }
    
    internal func getNaoPort() -> Int{
        return singleton.nao?.naoPort ?? 0000
    }
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
    
    ///gets Battery from Nao
    internal func getBattery() async -> Int {
        //get battery from nao
        var daten:Int = 0
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "batteryInfo",
            "naoIp" : "127.0.0.1",
            "naoPort" : "\(getNaoPort())"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data, error == nil else{
                print(error?.localizedDescription ?? "No data")
                return
            }
            let response = try? JSONSerialization.jsonObject(with: data, options:[])
            if let response = response as? [String: Any]{
                
                daten = response["data"] as! Int
                print(daten)
                
            }
        }
        task.resume()
        
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
            
            
            print(singleton.nao?.getLanguage() ?? "No Language Available")
        } catch {
            print("Invalid data")
        }
        setBatteryPercent(newBatteryPercent: daten)
        return daten
    }
    
    
    ///send text to speech form to nao
    func textToSpeech(text:String) async{
        /*
        let url = URL(string : "http://\(getIp()):\(pyServerPort)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "tts",
            "data" : [
                "text": "\(text)"
            ],
            "naoIP" : "\(getIp())",
            "naoPort" : "\(naoPort)"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
        */
        
        
        //diese zeile feuert fatal error, wenn man nicht mit dem now connected ist, da es diese URL nicht gibt.
        print(singleton.nao?.naoPort ?? "NoPyPort");
        print(singleton.nao?.pyPort ?? "NoPort");
        
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        
        print("url: \(url)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "tts",
            "data" : [
                "text" : "\(text)"
            ],
            "naoIp" : "127.0.0.1",
            "naoPort" : getNaoPort()
        ]
        
        let json = try? JSONSerialization.data(withJSONObject: parameters, options:[])
        print("json: \(json)")


        request.httpBody = json
        
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
            
            
            print(singleton.nao?.getLanguage() ?? "No Language Available")
        } catch {
            print("Invalid data")
        }
    }
    
    func move(){
        #warning("movement funktionalität implementieren.")
    }
    

    
    
    func playAudio(){
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "audioPlayer",
            "data" : [
                "path": "/home/nao/naoqui/hope.wav"
            ],
            "naoIp" : "127.0.0.1",
            "naoPort" : "\(getNaoPort())"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
    }
     
    func stopAudio(){
        let url = URL(string : "http://\(getIp()):\(getPyPort())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionId" : "audioStop",
            "naoIp" : "127.0.0.1",
            "naoPort" : "\(getNaoPort())"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
    }

    
    
}
