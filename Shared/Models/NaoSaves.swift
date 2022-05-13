//
//  NaoSaves.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 13.05.22.
//

import Foundation

class NaoSaves: ObservableObject, Identifiable {
    
    fileprivate let model = NaoSavesSingleton.sharedInstance
    
    //setter for naos
    public func setNaos(newNao: [NaoModel]) {
        model.naos = newNao
    }
    
    //getter for naos
    public func getNaos() -> [NaoModel] {
        return model.naos
    }
    
    //delete Nao
    public func deleteNao(nameOfNao: String) {
        #warning("TODO: implement delete")
    }
}

fileprivate class NaoSavesSingleton : ObservableObject {
    
    static let sharedInstance = NaoSavesSingleton()
    @Published var hasChanged = true
    
    fileprivate var naos: [NaoModel] = []
}

