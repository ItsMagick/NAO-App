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
    @Published var name: String = "-"
    @Published var battery: Int = 0
    @Published var cpu: Int = 0
    @Published var ip: String = "-"
    @Published var volume: Double = 0.0
    @Published var language: String = ""
    
    
    fileprivate let model = NaoModelSingleton.sharedInstance
    
    internal func modelNotifier() -> ObservableObjectPublisher {
        return model.objectWillChange
    }
    
    
    ///sets updatedBatteryPercent (from API call)
    internal func setBattery(batteryPercent : Int) {
        model.nao?.battery = batteryPercent
    }
    ///sets updatedCpuTemp (from API call)
    internal func setCpu(cpuDegree : Int) {
        model.nao?.cpu = cpuDegree
    }
    ///returns how much battery% the NAO has left
    internal func getBattery() -> Int {
        return model.nao?.battery ?? 0
    }
    ///returns the temperature of NAO's CPU
    internal func getCpu() -> Int {
        return model.nao?.cpu ?? 0
    }
    ///sets Volume
    internal func setVolume(newVolume : Double) {
        model.nao?.volume = newVolume
    }
    ///sets the language (available english, german)
    internal func setLanguage(newLanguage: String) {
        model.nao?.language = newLanguage
    }
}

///Singleton for the NAO-Model --> NAO saved here
internal class NaoModelSingleton : ObservableObject {
    static let sharedInstance = NaoModelSingleton()
    
    @Published internal var nao: NaoModel?
    
}


