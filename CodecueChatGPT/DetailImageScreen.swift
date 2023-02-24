//
//  DetailImageScreen.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 30/01/2023.
//

//import SwiftUI
//import UIKit
//import Foundation
//
//struct DetailImageScreen: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State var qureytext = ""
//    @State private var showShareSheet = false
//    @State private var imageUrl: String = ""
//    @State var imageList : [DALLEData] = []
//    @State private var isLoading = false
//    
//    @State private var showImageView  : Bool = false
//    @State private var imagesUrlsList  : [String] = []
//    @State private var selectionImageInPreview = 0
//   
//
//
//    var body: some View {
//        
//        ZStack{
//            AppColors.appBackgroundColor
//                .ignoresSafeArea(.all)
//            
//            
//            
//            VStack{
//                // top bar
//                HStack{
//                    
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }, label: {
//                        Image(systemName: "chevron.backward")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 15, height: 15)
//                            .foregroundColor(.white)
//                    })
//                    
//                    Spacer()
//                    
//                    Text("Image Generation")
//                        .foregroundColor(.white)
//                    
//                    Spacer()
//                    
//                 
//                    
//                }
//                .padding(.top,20)
//                
//                
//                VStack{
//                    Spacer()
//                    Text("Coming Soon")
//                        .foregroundColor(.white)
//                        .font(.title)
//                    Spacer()
//                }
//                
////                if(self.isLoading){
////                    ScrollView(.vertical , showsIndicators: false){
////
////                        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
////
////                            ForEach(0...10, id:\.self){ index in
////
////                                ShimmerView(cornerRadius: 10, fill: .gray.opacity(0.5))
////                                    .frame(width: 150, height: 150)
////                                    .padding(.top,20)
////
////                            }
////                        }
////                    }
////                    .clipped()
////                }
////                else{
////
////                    ScrollView(.vertical, showsIndicators: false){
////                        if(!self.imageList.isEmpty){
////
////                            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
////
////                                ForEach(self.imageList.indices, id : \.self){index in
////
////                                    ImagesCard(imageModel: self.imageList[index], showImageView: self.$showImageView, imagesUrlsList: self.$imagesUrlsList, selectionImageInPreview: self.$selectionImageInPreview )
////
////
////                                }
////                            }
////
////                        }
////
////
////                    }
////                }
//               
//                
////                HStack{
////                    TextField("Open AI Waiting for your query", text: $qureytext)
////                        .foregroundColor(AppColors.appBackgroundColor)
////                        .padding(15)
////                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
////
////
////                    if isLoading {
////                       ProgressView()
////                            .foregroundColor(.white)
////                            .padding(.leading,5)
////                    }else{
////
////
////                            Button(action: {
////                                generateImage(imageList: self.$imageList)
////
////                            }, label: {
////                                Image(systemName: "paperplane")
////                                    .resizable()
////                                    .aspectRatio( contentMode: .fit)
////                                    .frame(width: 24, height: 24)
////                                    .foregroundColor(.white)
////                                    .padding(.leading,5)
////                                    .rotationEffect(self.qureytext != "" ? .degrees(0) : .degrees(40))
////                            })
////
////
////
////
////                    }
////
////
////                }
//                
////                BannerWrapper().frame(height: 50)
//              
//                
//            }
//            .padding(.leading,20)
//            .padding(.trailing,20)
//            
////            ImageViewer(imageURLs: self.$imagesUrlsList, selected : self.$selectionImageInPreview  , viewerShown: self.$showImageView, caption: nil, closeButtonTopRight: true)
//
//         
//        }
//        .navigationBarHidden(true)
//    }
//    
//    private func generateImage(imageList: Binding<[DALLEData]>) {
//        isLoading = true
//        let apiKey = "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"
//        let description = qureytext
//        let request = generateImageRequest(apiKey: apiKey, description: description)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(DALLEResult.self, from: data)
//                    DispatchQueue.main.async {
//                        
//                        if (!result.data.isEmpty){
//                            imageList.wrappedValue.removeAll()
//                            imageList.wrappedValue.append(contentsOf: result.data)
//                            
//                            
//                        }
////                        self.imageUrl = result.data[0].url
//                    }
//                } catch {
//                    print("Failed to decode response: \(error)")
//                }
//                
//                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                print(responseJSON ?? "")
//            }
//            self.isLoading = false
//        }.resume()
//        self.qureytext = ""
//    }
//
//    private func generateImageRequest(apiKey: String, description: String) -> URLRequest {
//        let endpoint = "https://api.openai.com/v1/images/generations"
//        let request = NSMutableURLRequest(url: URL(string: endpoint)!)
//        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "POST"
//        request.httpBody = """
//            {
//                "model": "image-alpha-001",
//                "prompt": "\(description)",
//                "num_images":10,
//                "size":"1024x1024"
//            }
//            """.data(using: .utf8)
//
//        return request as URLRequest
//    }
//}
//
//
//struct DALLEResult: Decodable {
//    let data: [DALLEData]
//}
//
//struct DALLEData: Decodable {
//    let url: String
//    
//}
//
//
//struct ImagesCard : View{
//    
//    
//    @State private var showShareSheet = false
//    
//    var imageModel : DALLEData
//
//    
//    @Binding var showImageView  : Bool
//    @Binding var imagesUrlsList  : [String]
//    @Binding var selectionImageInPreview : Int
//    
//    init(imageModel : DALLEData, showImageView: Binding<Bool>, imagesUrlsList: Binding<[String]>, selectionImageInPreview: Binding<Int> ) {
//        self.imageModel = imageModel
//        self._showImageView = showImageView
//        self._imagesUrlsList = imagesUrlsList
//        self._selectionImageInPreview = selectionImageInPreview
//    }
//  
//    
//   
//    var body: some View{
//        
//        VStack{
//        
//                VStack{
//                    KFImage(URL(string: imageModel.url))
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 150 , height: 150)
//                        .cornerRadius(8)
//                        .padding(.top,20)
//                        .onTapGesture{
//                            self.imagesUrlsList.removeAll()
//                            self.imagesUrlsList.append(self.imageModel.url )
//                            self.selectionImageInPreview = 0
//                            self.showImageView = true
//                        }
//                    
//                
//                    HStack{
//                        
////                        Button(action: {
////                            self.showShareSheet = true
////                            
////                        }, label: {
////                            ShareLink(item: self.imageModel.url){
////                                Label("", systemImage: "square.and.arrow.up")
////                                    .foregroundColor(.white)
////
////                            }
////                        })
//                        
////                        Button(action: {
////
////                        }, label: {
////                            Image(systemName: "square.and.arrow.down")
////                                .resizable()
////                                .aspectRatio(contentMode: .fill)
////                                .frame(width: 20 , height: 20)
////                                .foregroundColor(.white)
////
////                        })
//                       
//                    }
//                    
//                    
//                }
//            
//                
//        }
//    }
////    func saveImage() {
////        let image = UIImage(named: imageModel.url)!
////        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
////    }
//}
//
//
