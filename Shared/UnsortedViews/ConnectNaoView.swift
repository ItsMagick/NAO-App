//
//  ConnectNao.swift
//  NAO-App
//
//  Created by Jan Rubner on 28.06.22.
//

import SwiftUI
let ipValidation = try! NSRegularExpression(pattern: "((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\(".")|$)){4}")
struct ConnectNaoView: View {
    @State var ipText: String = ""
    @FocusState private var isFocused: Bool
    @State private var isDisabled: Bool = true
    
    var body: some View {
        
        VStack {
            TextField("IP Adresse",
                      text: $ipText)
            .focused($isFocused)
            .onSubmit {
                if (ipText.isValidWith(regex: ipText) == true){
                    isDisabled = false
                }
            }
                .keyboardType(.numbersAndPunctuation)
                //.onSubmit(/* if isValidWith(regex: $ipText) == true{*/)
                .textFieldStyle(.roundedBorder)
                .padding()
                .frame(width: 200)
            HStack {
                Button("Fertig") {
                    let nao = NaoModel()
                    nao.name = "Nao"
                    nao.ip = ipText
                    NaoModelSingleton.sharedInstance.nao = nao
                }.buttonStyle(.borderedProminent)
                    .disabled(isDisabled)
                
                Button("Löschen") {
                    ipText = ""
                }.buttonStyle(.borderedProminent)
            }
            
        }
        
    }
    
}

extension String {
    func isValidWith(regex:String) ->Bool {
        
        let range = NSRange(location:0, length: self.utf16.count)
        if ipValidation.firstMatch(in: self, options: [], range: range) != nil {
            return true
        }
        return false
    }
    
}

struct ConnectNao_Previews: PreviewProvider {
    static var previews: some View {
        ConnectNaoView()
    }
}
