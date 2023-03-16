//
//  AdMob.swift
//  ChatUI
//
//  Created by Sohaib Sajjad on 02/01/2023.
//

import Foundation
import UIKit
import GoogleMobileAds




final class OpenAd: NSObject, GADFullScreenContentDelegate {
   var appOpenAd: GADAppOpenAd?
   var loadTime = Date()
   
   func requestAppOpenAd() {
       let request = GADRequest()
       GADAppOpenAd.load(withAdUnitID: "ca-app-pub-7540620933217632/6901929000",
                         request: request,
                         orientation: UIInterfaceOrientation.portrait,
                         completionHandler: { (appOpenAdIn, _) in
                           self.appOpenAd = appOpenAdIn
                           self.appOpenAd?.fullScreenContentDelegate = self
                           self.loadTime = Date()
                           print("[OPEN AD] Ad is ready")
                         })
   }
   
   func tryToPresentAd() {
       print("tried")
       if let gOpenAd = self.appOpenAd, wasLoadTimeLessThanNHoursAgo(thresholdN: 4) {
           gOpenAd.present(fromRootViewController: (UIApplication.shared.windows.first?.rootViewController)!)
       } else {
           self.requestAppOpenAd()
       }
   }
   
   func wasLoadTimeLessThanNHoursAgo(thresholdN: Int) -> Bool {
       let now = Date()
       let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(self.loadTime)
       let secondsPerHour = 3600.0
       let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour
       return intervalInHours < Double(thresholdN)
   }
   
 
   
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        requestAppOpenAd()
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        requestAppOpenAd()
    }

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd){
        print("Ad did present")
    }
}




