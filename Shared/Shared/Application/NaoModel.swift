//
//  NaoModel.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 28.06.22.
//

import Foundation
import Combine


class NaoModel : ObservableObject {
    /*
     the information you get from the NAO-Server will be saved here
     */
    var name: String = "NAO"
    var battery: Int = 0
    var cpu: Int = 0
    var ip: String = "-"
    var volume: Double = 0.0
    var language: String = ""
    let pyPort = 8232
    let naoPort = 9559
    
    
    
    fileprivate let model = NaoModelSingleton.sharedInstance
    
    internal func modelNotifier() -> ObservableObjectPublisher {
        return model.objectWillChange
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
    internal func setVolume(newVolume : Double) {
        model.nao?.volume = newVolume
    }
    ///gets Volume from model
    internal func getVolume() -> Double {
        return model.nao?.volume ?? 0.0
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
    
    internal func getName() -> String {
        return model.nao?.name ?? ""
    }
}


///Singleton for the NAO-Model --> NAO saved here
internal class NaoModelSingleton : ObservableObject {
    static let sharedInstance = NaoModelSingleton()
    
    @Published internal var nao: NaoModel?
    
}


