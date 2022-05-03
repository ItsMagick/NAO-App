//
//  ContentView.swift
//  Shared
//
//  Created by Sebastian Peschke on 03.05.22.
//

import SwiftUI

struct StartContentView: View {
    var body: some View {
        Text("Gamma Robotics")
            .font(.largeTitle)
            .padding()
    }
}

struct FindNaoContentView : View {
    var body: some View {
        Text("Finde Nao")
        Text("Test")
            .padding()  
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartContentView()
            FindNaoContentView()
        }
    }
}
