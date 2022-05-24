//
//  NaoModel.swift
//  NAO-App (iOS)
//
//  Created by Burak Güccük on 10.05.22.
//

import Foundation
import SwiftUI
import Alamofire


class NaoModel: Codable, Identifiable{
    var PORT = 9559
    var IP = "127.0.0.1"
    var PROTOCOL = "http"
    
    init () {
    
    }
    
    init(ipAdress ip: String, port p: Int){
        IP = ip
        PORT = p
    }
    
    //Konstruiert eine URL für den NAO
    var naoURL : String {
        get {
            return "\(PROTOCOL)://\(IP):\(PORT)"
        }
    }
    
    private func send (params:[String: String], callback: ((Bool, String?) -> ())?){
        AF.request(naoURL, parameters: params)
            .responseString{
                res in if let cb = callback {
                    cb(res.result.isSuccess.self && res.result.rawValue != "error", res.result.rawValue)
                }
            }
    }
    
    
    //Posture Api
    
    enum Posture: String {
        case Stand      = "Stand"
        case StandInit  = "StandInit"
        case StandZero  = "StandZero"
        case Crouch     = "Crouch"
        case Sit        = "Sit"
        case SitRelax   = "SitRelax"
        case LyingBelly = "LyingBelly"
        case LyingBack  = "LyingBack"
    }
    
    // Goes to a predefined posture, an "intelligent" command
    func goTo (posture p: Posture, speed s: Float, completion cb: @escaping (Bool, String?) -> ()) {
          // Only accepting speed between 0 and 1
          if s < 0 || s > 1 {
              cb(false, nil)
              return
          }
          
          send(params: [ "goTo": p.rawValue, "speed": s.description ], callback: cb)
      }
    
    // Applies a predefined posture, used for animation, not "intelligent"
    func apply (posture p: Posture, speed s: Float, completion cb: @escaping (Bool, String?) -> ()) {
            // Only accepting speed between 0 and 1
            if s < 0 || s > 1 {
                cb(false, nil)
                return
            }
            
            send(params: [ "apply": p.rawValue, "speed": s.description ], callback: cb)
        }
        
        
        // Stops the current posture interpolation
    func stop (completion cb: @escaping (Bool, String?) -> ()) {
            send(params: [ "stop": "true" ], callback: cb)
        }
        
        
        // NAVIGATION API
      
        // Makes Nao move to the given pose in the ground plane, relative to FRAME_ROBOT
    func moveTo (x x: Float, y: Float, theta: Float, completion cb: @escaping (Bool, String?) -> ()) {
            if theta < -3.1415 || theta > 3.1415 {
                cb(false, nil)
                return
            }
            
            send(params: [ "moveTo": "true", "x": x.description, "y": y.description, "t": theta.description ], callback: cb)
        }
        

        // MOTION API
        
        // Wake motors up
    func wake (completion cb: @escaping (Bool, String?) -> ()) {
            send(params: [ "wake": "true" ], callback: cb)
        }
        
        // Sets motors off
    func rest (completion cb: @escaping (Bool, String?) -> ()) {
            send(params: [ "rest": "true" ], callback: cb)
        }
        
        // TEXTTOSPEECH API
        
        // Says the specified string of characters.
    func say (s: String, completion cb: @escaping (Bool, String?) -> ()) {
            send(params: [ "say": s ], callback: cb)
        }
    }
    //Wie kommt das bei uns an ?
    


