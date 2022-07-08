//
//  CameraView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject var vm: CameraViewModel
    @State var isViewDisplayed : Bool
    var body: some View {
        #warning("Do not uncomment this command")
        /*
        Image(uiImage: (vm.getImages()))
            .scaledToFit()
            .onAppear {
            while (isViewDisplayed){
                
                // TODO: while view is displayed request images from nao, decode from base64 to image, display in camera view
                vm.getImages()
                
                
            }
        }
         */
        
         
        Text("Fill in video from API Call!")
            .onAppear {
                self.isViewDisplayed = true
                
                        
            }
            .onDisappear {
                self.isViewDisplayed = false
            }
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(vm: CameraViewModel.init(), isViewDisplayed: true)
    }
}
