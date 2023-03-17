//
//  HomeScreen.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 30/01/2023.
//

import SwiftUI
import Foundation
import GoogleMobileAds
import UIKit
import StoreKit

struct HomeScreen: View {
    @State var description = ""
    @State var toDetail : Bool = false
    @State var toImageDetail : Bool = false
    @State var showButtons : Bool = false
    
    var ad = OpenAd()
   
    
    @State var interstitial: GADInterstitialAd?

    @State private var showRecommended = false

    @State var isLoadingFirstTime = true
    

    var body: some View {
        ZStack{
            AppColors.appBackgroundColor
                .ignoresSafeArea(.all)
            
            VStack{
                Spacer()
                
                Image(uiImage: UIImage(named: AppImages.appLogo)!)
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(height: 200)
                    .padding(.bottom,30)
                
                
                Spacer()
                
                if(self.showButtons){
                    
                    NavigationLink(destination: DetailTextScreen(), isActive: self.$toDetail){
                        EmptyView()
                    }
                    
                    Button(action: {
                        self.toDetail = true
                        interstitial?.present(fromRootViewController: UIApplication.shared.windows.first?.rootViewController ?? UIViewController())

                    }, label: {
                        HStack{
                            Image(systemName: "text.bubble")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(.leading,5)

                            
                            Text("Text Completion - AI Chat")
                                .foregroundColor(.white)
                                .padding(.leading,5)
                            
                            Spacer()
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(AppColors.appBackgroundColor).shadow(color: .black, radius: 10).opacity(0.5))
                        .background(RoundedRectangle(cornerRadius: 10).stroke(.white,lineWidth: 1))
                    
                    })
                      
                    
                    
//                    NavigationLink(destination: DetailImageScreen(), isActive: self.$toImageDetail){
//                        EmptyView()
//                    }
//                        Button(action: {
//                            self.toImageDetail = true
//                        }, label: {
//                            HStack{
//                                Image(systemName: "photo")
//                                    .resizable()
//                                    .aspectRatio( contentMode: .fit)
//                                    .frame(width: 30, height: 30)
//                                    .foregroundColor(.white)
//                                    .padding(.leading,5)
//
//
//                                Text("Image Generation - OpenAI")
//                                    .foregroundColor(.white)
//                                    .padding(.leading,5)
//
//                                Spacer()
//
//                            }
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 10).fill(AppColors.appBackgroundColor).shadow(color: .black, radius: 10).opacity(0.5))
//                            .background(RoundedRectangle(cornerRadius: 10).stroke(.white,lineWidth: 1))
//                            .padding(.top,20)
//                        })
//
                    
                  
                    Spacer()
                    
                   
//                    Link("View more Apps", destination: URL(string: "https://apps.apple.com/app-id")!)
//                        .foregroundColor(.white)
//                        .padding(.bottom,20)

                  

                    BannerWrapper().frame(height: 50)
                  
                
                }
                   

              

             
                
            }
            .padding(.leading,20)
            .padding(.trailing,20)
            
        }
        .navigationBarHidden(true)
        .onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                DispatchQueue.global(qos: .background).async {
                    withAnimation{
                        self.showButtons = true
                    }
                }
            })
            
                
                ad.tryToPresentAd()
                
        }
        .onAppear(perform: {
                    let request = GADRequest()
                            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-7540620933217632/7261281419",
                                                        request: request,
                                              completionHandler: { [self] ad, error in
                                if error != nil {
                                                  return
                                                }
                                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = [self] as? any GADFullScreenContentDelegate
                                              }
                            )

                })
       

    }
}


struct OpenAIAPI {
    static let endpoint = "https://api.openai.com/v1/completions"
    static let apiKey = "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"
}

struct Choice : Codable, Hashable{
    let text : String?
    let finish_reason : String?
    let index : Int?
}

struct ApiResponse : Codable, Hashable{
    let choices : [Choice]?
}


import Alamofire

func generateText(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
    let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "Bearer \(OpenAIAPI.apiKey)"
    ]
    
    let parameters = [
        "prompt": prompt,
        "max_tokens": 2000,
        "temperature": 0.5,
        "model" : "text-davinci-001"
    ] as [String : Any]
    
    
    AF.request(OpenAIAPI.endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .responseJSON { response in
           
            
            
            switch response.result {
                
            case .success(let value):
               
                var strings = ""
                
                let response1 = value as! NSDictionary
                
                do{
                    let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: response.data!)
                    for choice in apiResponse.choices ?? []{
                        strings += choice.text ?? ""
                    }
                }
                catch{
                    print("decoding error")
                    print(error)
                }
                completion(.success(strings))
            case .failure(let error):
                completion(.failure(error))

            }
        }
    
}



//import Foundation
//import SwiftUI
//
//
//
//struct DALLEImage: View {
//    @State private var imageUrl: String? = nil
//
//    var body: some View {
//        if let imageUrl = imageUrl {
//            return AnyView(
//                Image(uiImage: UIImage(contentsOf: URL(string: imageUrl)!)!)
//                    .resizable()
//            )
//        } else {
//            generateImage()
//            return AnyView(
//                Text("Loading image...")
//            )
//        }
//    }
//
//    private func generateImage() {
//        let apiKey = "your_api_key_here"
//        let description = "a red apple"
//        let request = generateImageRequest(apiKey: apiKey, description: description)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(DALLEResult.self, from: data)
//                    DispatchQueue.main.async {
//                        self.imageUrl = result.data[0].url
//                    }
//                } catch {
//                    print("Failed to decode response: \(error)")
//                }
//            }
//        }.resume()
//    }
//
//    private func generateImageRequest(apiKey: String, description: String) -> URLRequest {
//        let endpoint = "https://api.openai.com/v1/images/generations"
//        let request = NSMutableURLRequest(url: URL(string: endpoint)!)
//
//        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "POST"
//        request.httpBody = """
//            {
//                "model": "image-alpha-001",
//                "prompt": "\(description)",
//                "num_images":1,
//                "size":"1024x1024"
//            }
//            """.data(using: .utf8)
//
//        return request as URLRequest
//    }
//}


final private class BannerVC: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(.infinity))

        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-7540620933217632/6763954948"
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(.infinity).size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}


struct BannerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<BannerWrapper>) -> UIViewController {
        let viewController = UIViewController()
        let bannerView = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(340))
        addBannerViewToView(bannerView, viewController: viewController)
        bannerView.adUnitID = "ca-app-pub-7540620933217632/6763954948"
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


