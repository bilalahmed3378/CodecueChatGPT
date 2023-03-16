//
//  CodecueChatGPTApp.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 30/01/2023.
//

import SwiftUI
import GoogleMobileAds



@main
struct CodecueChatGPTApp: App {
//    let adsVM = AdsViewModel.shared
     
//    @Environment(\.scenePhase) private var scenePhase
//       var ad = OpenAd()

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(adsVM)

        }
//        .onChange(of: scenePhase) { phase in
//                   if phase == .active {
//                       ad.tryToPresentAd()
//                   }
//               }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GADMobileAds.sharedInstance().start(completionHandler: nil)

        return true
    }
    
    

}

