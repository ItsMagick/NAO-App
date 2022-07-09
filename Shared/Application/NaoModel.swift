//
//  NaoModel.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 28.06.22.
//


import Combine
import SwiftUI

class NaoModel : ObservableObject {
    /*
     the information you get from the NAO-Server will be saved here
     */
    var image: Image = Image("")
    var name: String = "NAO"
    @Published var battery: Int = 0
    @Published var cpu: Int = 0
    @Published var ip: String = "-"
    @Published var volume: Int = 0
    @Published var language: String = ""
    @Published var languageSelected: Int = 0
    let pyPort = 8283
    let naoPort = 9559
    
    
    
    fileprivate let model = NaoModelSingleton.sharedInstance
    
    internal func modelNotifier() -> ObservableObjectPublisher {
        return model.objectWillChange
    }
    
    
    /*
        IMAGE
     */
    ///sets image form Stream
    internal func setImage(image:Image){
        model.nao?.image = image
    }
    
    internal func getImages() -> Image{
        return model.nao?.image ?? Image("")
    }
    
    
    /*
        BATTERY
     */
    ///sets updatedBatteryPercent (from API call)
    internal func setBattery(batteryPercent : Int) {
        model.nao?.battery = batteryPercent
    }
    ///returns how much battery% the NAO has left from model
    internal func getBattery() -> Int {
        return model.nao?.battery ?? 0
    }
    
    /*
        CPUTemp
     */
    ///sets updatedCpuTemp (from API call)
    internal func setCpu(cpuDegree : Int) {
        model.nao?.cpu = cpuDegree
    }
    ///returns the temperature of NAO's CPU from model
    internal func getCpu() -> Int {
        return model.nao?.cpu ?? 0
    }
    
    /*
        VOLUME
     */
    ///sets Volume to model
    internal func setVolume(newVolume : Int) {
        model.nao?.volume = newVolume
    }
    ///gets Volume from model
    internal func getVolume() -> Int {
        return model.nao?.volume ?? 0
    }

    /*
        LANGUAGE
     */
    ///sets the language (available english, german) to model
    internal func setLanguage(newLanguage: String) {
        model.nao?.language = newLanguage
    }
    ///gets Language from model
    internal func getLanguage() -> String {
        return model.nao?.language ?? ""
    }
    
    /*
        IP
     */
    ///get ip from model
    internal func getIp() -> String {
        return model.nao?.ip ?? ""
    }
    ///set ip in model
    internal func setIp(newIp: String) {
        model.nao?.ip = newIp
    }
    ///gets name from model
    internal func getName() -> String {
        return model.nao?.name ?? ""
    }
    
    internal func getNaoPort() -> Int {
        return model.nao?.naoPort ?? 0
    }
    
    internal func getPyPort() -> Int {
        return model.nao?.pyPort ?? 0
    }
    
    
    
}


///Singleton for the NAO-Model --> NAO saved here
internal class NaoModelSingleton : ObservableObject {
    static let sharedInstance = NaoModelSingleton()
    
    @Published internal var nao: NaoModel?
    
}

struct NaoJSONModel : Codable {
    var messageId : String?
    var success : Bool?
    var data : NaoData?
    var message : String?
    
}
struct NaoData : Codable {
    var batteryInfo : Int?
    //not sure if cpuTemp is really an Int!
    var cpuTemp : Int?
    var base64Jpeg : String?
    
}

