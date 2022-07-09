//
//  CameraView.swift
//  NAO-App (iOS)
//
//  Created by Jan Rubner on 21.06.22.
//

import SwiftUI

//currently not working since the endpoint returns base64 String, needs to be parsed and castet to Image
struct CameraView: View {
    @ObservedObject var vm: CameraViewModel
    
    @State var isViewDisplayed : Bool
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        vm.getImages()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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
        
        
        //Could be inherited but not possible at the moment
        
//        Text("Fill in video from API Call!")
//            .onAppear {
//                self.isViewDisplayed = true
//
//
//            }
//            .onDisappear {
//                self.isViewDisplayed = false
//            }
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(vm: CameraViewModel.init(), isViewDisplayed: true)
    }
}
