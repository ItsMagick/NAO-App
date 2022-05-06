//
//  MainView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 06.05.22.
//

import SwiftUI

struct MainView: View {
    
//dummy data
  @State var disciplines = ["Motion", "Speech Text", "Recorder", ".", ".","."]

  var body: some View {
//list for mainView w/ dummy data in VStack
      VStack{
          //placeholder for camera
          Rectangle()
              .size(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)/3)
              .padding()
              

          List(disciplines, id: \.self) { discipline in
            Text(discipline)
                  .font(.headline)
          }
      }
  }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
