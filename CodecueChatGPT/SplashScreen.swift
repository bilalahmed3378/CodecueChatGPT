//
//  SplashScreen.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 30/01/2023.
//
import Foundation
import SwiftUI

struct SplashScreen: View {
    @State var toHome : Bool = false
    var body: some View {
        ZStack{
            NavigationLink(destination: HomeScreen(), isActive: self.$toHome){
            }
            
            AppColors.appBackgroundColor
                .ignoresSafeArea(.all)
            
            Image(uiImage: UIImage(named: AppImages.appLogo)!)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(height: 300)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.toHome = true
                    }
                }

            
            
        }
        .navigationBarHidden(true)
       
    }
}


   
