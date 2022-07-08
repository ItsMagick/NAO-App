//
//  CameraView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct CameraView: View {
    @State var isViewDisplayed : Bool
    var body: some View {
        Text("Fill in video from API Call!")
            .onAppear {
                self.isViewDisplayed = true
                while (isViewDisplayed){
                    
                    // TODO: while view is displayed request images from nao, decode from base64 to image, display in camera view
                    
                }
                        
            }
            .onDisappear {
                self.isViewDisplayed = false
            }
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(isViewDisplayed: true)
    }
}
