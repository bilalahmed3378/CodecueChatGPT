//
//  AdMob.swift
//  ChatUI
//
//  Created by Sohaib Sajjad on 02/01/2023.
//

//import Foundation
//import UIKit
//import GoogleMobileAds
//
//
//class ViewController: UIViewController, GADFullScreenContentDelegate {
//
//    private var interstitial: GADInterstitialAd?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let request = GADRequest()
//        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
//                               request: request,
//                               completionHandler: { [self] ad, error in
//            if let error = error {
//                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//                return
//            }
//            interstitial = ad
//            interstitial?.fullScreenContentDelegate = self
//        }
//        )
//    }
//
//    /// Tells the delegate that the ad failed to present full screen content.
//    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//        print("Ad did fail to present full screen content.")
//    }
//
//    /// Tells the delegate that the ad will present full screen content.
//    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("Ad will present full screen content.")
//    }
//
//    /// Tells the delegate that the ad dismissed full screen content.
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("Ad did dismiss full screen content.")
//    }
//
//    @IBAction func doSomething(_ sender: Any) {
//      if interstitial != nil {
//          interstitial?.present(fromRootViewController: self)
//      } else {
//        print("Ad wasn't ready")
//      }
//    }
//
//}
//
//

//import Foundation
//import UIKit
//import SwiftUI
//import GoogleMobileAds

//class InterstitialAd: NSObject {
//    var interstitialAd: GADInterstitialAd?
//
//    //Want to have one instance of the ad for the entire app
//    //We can do this b/c you will never show more than 1 ad at once so only 1 ad needs to be loaded
//    static let shared = InterstitialAd()
//
//    func loadAd(withAdUnitId id: String) {
//        let req = GADRequest()
//        GADInterstitialAd.load(withAdUnitID: id, request: req) { interstitialAd, err in
//            if let err = err {
//                print("Failed to load ad with error: \(err)")
//                return
//            }
//
//            self.interstitialAd = interstitialAd
//        }
//    }
//}
//
//
//final class InterstitialAdView: NSObject, UIViewControllerRepresentable, GADFullScreenContentDelegate {
//
//    //Here's the Ad Object we just created
//    let interstitialAd = InterstitialAd.shared.interstitialAd
//    @Binding var isPresented: Bool
//    var adUnitId: String
//
//    init(isPresented: Binding<Bool>, adUnitId: String) {
//        self._isPresented = isPresented
//        self.adUnitId = adUnitId
//        super.init()
//
//        interstitialAd?.fullScreenContentDelegate = self //Set this view as the delegate for the ad
//    }
//
//    //Make's a SwiftUI View from a UIViewController
//    func makeUIViewController(context: Context) -> UIViewController {
//        let view = UIViewController()
//
//        //Show the ad after a slight delay to ensure the ad is loaded and ready to present
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
//            self.showAd(from: view)
//        }
//
//        return view
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//
//    }
//
//    //Presents the ad if it can, otherwise dismisses so the user's experience is not interrupted
//    func showAd(from root: UIViewController) {
//
//        if let ad = interstitialAd {
//            ad.present(fromRootViewController: root)
//        } else {
//            print("Ad not ready")
//            self.isPresented.toggle()
//        }
//    }
//
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        //Prepares another ad for the next time view presented
//        InterstitialAd.shared.loadAd(withAdUnitId: adUnitId)
//
//        //Dismisses the view once ad dismissed
//        isPresented.toggle()
//    }
//}
//
//
//struct FullScreenModifier<Parent: View>: View {
//    @Binding var isPresented: Bool
//    @State var adType: AdType
//
//    //Select adType
//    enum AdType {
//        case interstitial
//        case rewarded
//    }
//
//    var rewardFunc: () -> Void
//    var adUnitId: String
//
//    //The parent is the view that you are presenting over
//    //Think of this as your presenting view controller
//    var parent: Parent
//
//    var body: some View {
//        ZStack {
//            parent
//
//            if isPresented {
//                EmptyView()
//                    .edgesIgnoringSafeArea(.all)
//
//                if adType == .interstitial {
//                    InterstitialAdView(isPresented: $isPresented, adUnitId: adUnitId)
//                }
//            }
//        }
//        .onAppear {
//            //Initialize the ads as soon as the view appears
//            if adType == .interstitial {
//                InterstitialAd.shared.loadAd(withAdUnitId: adUnitId)
//            }
//        }
//    }
//}
//
//extension View {
//    public func presentRewardedAd(isPresented: Binding<Bool>, adUnitId: String, rewardFunc: @escaping (() -> Void)) -> some View {
//        FullScreenModifier(isPresented: isPresented, adType: .rewarded, rewardFunc: rewardFunc, adUnitId: adUnitId, parent: self)
//    }
//
//    public func presentInterstitialAd(isPresented: Binding<Bool>, adUnitId: String) -> some View {
//        FullScreenModifier(isPresented: isPresented, adType: .interstitial, rewardFunc: {}, adUnitId: adUnitId, parent: self)
//    }
//}
//



//let adUnitID = "ca-app-pub-3940256099942544/4411468910"
//
//
//final class Interstitial: NSObject, GADFullScreenContentDelegate {
//    private var interstitial: GADInterstitialAd?
//
//    override init() {
//        super.init()
//        loadInterstitial()
//    }
//
//    func loadInterstitial(){
//        let request = GADRequest()
//        GADInterstitialAd.load(withAdUnitID:adUnitID,
//                                    request: request,
//                          completionHandler: { [self] ad, error in
//                            if let error = error {
//                              print("Failed to load interstitial ad: \(error.localizedDescription)")
//                              return
//                            }
//                            interstitial = ad
//                            interstitial?.fullScreenContentDelegate = self
//                          }
//        )
//    }
//
//    /// Tells the delegate that the ad failed to present full screen content.
//    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//        print("Ad did fail to present full screen content.")
//    }
//
////    /// Tells the delegate that the ad presented full screen content.
////    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
////        print("Ad did present full screen content.")
////    }
//
//    /// Tells the delegate that the ad dismissed full screen content.
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("Ad did dismiss full screen content.")
//        loadInterstitial()
//    }
//
//    func showAd(){
//        let root = UIApplication.shared.windows.first?.rootViewController
//        interstitial?.present(fromRootViewController: root!)
//    }
//}
//

 
import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport
import UIKit

class AdsManager: NSObject, ObservableObject {
    
    private struct AdMobConstant {
        static let interstitial1ID = "ca-app-pub-3940256099942544/4411468910"
    }
    
    final class Interstitial: NSObject, GADFullScreenContentDelegate, ObservableObject {

        private var interstitial: GADInterstitialAd?
        
        override init() {
            super.init()
            requestInterstitialAds()
        }

        func requestInterstitialAds() {
            let request = GADRequest()
            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                GADInterstitialAd.load(withAdUnitID: AdMobConstant.interstitial1ID, request: request, completionHandler: { [self] ad, error in
                    if let error = error {
                        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                        return
                    }
                    interstitial = ad
                    interstitial?.fullScreenContentDelegate = self
                })
            })
        }
        func showAd() {
            let root = UIApplication.shared.windows.last?.rootViewController
            if let fullScreenAds = interstitial {
                fullScreenAds.present(fromRootViewController: root!)
            } else {
                print("not ready")
            }
        }
        
    }
    
    
}


class AdsViewModel: ObservableObject {
    static let shared = AdsViewModel()
    @Published var interstitial = AdsManager.Interstitial()
    @Published var showInterstitial = false {
        didSet {
            if showInterstitial {
                interstitial.showAd()
                showInterstitial = false
            } else {
                interstitial.requestInterstitialAds()
            }
        }
    }
}





struct BannerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<BannerWrapper>) -> UIViewController {
        let viewController = UIViewController()
        let bannerView = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(340))
        addBannerViewToView(bannerView, viewController: viewController)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = viewController
        bannerView.load(GADRequest())
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<BannerWrapper>) {
    }
    
    private func addBannerViewToView(_ bannerView: GADBannerView, viewController: UIViewController) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(bannerView)
        viewController.view.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor).isActive = true
    }
}


