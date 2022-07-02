//
//  MainViewModel.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 01.07.22.
//

import Foundation
import Combine

class MainViewModel : ObservableObject {
    let naoPort = 9559
    let pyServerPort = 8283
    
    //let url = URL(string : "http://\(getIp()):\(port)")!
    
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
    
    ///gets Battery from Nao
    internal func getBattery() -> Int{
        //get battery from nao
        var daten:Int = 0
        let url = URL(string : "http://\(getIp()):\(pyServerPort)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "batteryInfo",
            "naoIP" : "\(getIp())",
            "naoPort" : "\(naoPort)"
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
            }
        }
        task.resume()
        setBatteryPercent(newBatteryPercent: daten)
        return daten
    }
    
    
    ///send text to speech form to nao
    func textToSpeech(text:String){
        let url = URL(string : "http://\(getIp()):\(pyServerPort)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
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
        
    }
    
    func move(){
        #warning("movement funktionalität implementieren.")
    }
    

    
    
    func playAudio(){
        let url = URL(string : "http://\(getIp()):\(pyServerPort)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "audioPlayer",
            "data" : [
                "path": "/home/nao/naoqui/hope.wav"
            ],
            "naoIP" : "\(getIp())",
            "naoPort" : "\(naoPort)"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
    }
     
    func stopAudio(){
        let url = URL(string : "http://\(getIp()):\(pyServerPort)")!
        var request = URLRequest(url: url)
        request.setValue("spplication/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "messageId" : "0",
            "actionID" : "audioStop",
            "naoIP" : "\(getIp())",
            "naoPort" : "\(naoPort)"
        ]
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = json
    }

    
    
}
