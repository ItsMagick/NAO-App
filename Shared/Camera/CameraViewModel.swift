//
//  CameraViewModel.swift
//  NAO-App (iOS)
//
//  Created by Sebastian Peschke on 08.07.22.
//

import SwiftUI
import Combine

class CameraViewModel : ObservableObject{
    
    var network = NetworkLayer()
    
    fileprivate let singleton = NaoModelSingleton.sharedInstance
    
    init() {
        
    
    }
    
    internal func modelNotifier() -> ObservableObjectPublisher {
        return singleton.objectWillChange
    }
    
    func getImages() -> Image{
        return singleton.nao?.getImages() ?? Image("")
    }
    
    
    
    
}
