//
//  HomeScreen.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 30/01/2023.
//

import SwiftUI
import Foundation

struct HomeScreen: View {
    @State var description = ""
    @State var toDetail : Bool = false
    @State var toImageDetail : Bool = false

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
                
                NavigationLink(destination: DetailTextScreen(), isActive: self.$toDetail){
                    HStack{
                        Image(systemName: "text.bubble")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(.leading,5)

                        
                        Text("Text Completion - OpenAI")
                            .foregroundColor(.white)
                            .padding(.leading,5)
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(AppColors.appBackgroundColor).shadow(color: .black, radius: 10).opacity(0.5))
                }
                
                
                NavigationLink(destination: DetailImageScreen(), isActive: self.$toImageDetail){
                    HStack{
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(.leading,5)

                        
                        Text("Image Generation - OpenAI")
                            .foregroundColor(.white)
                            .padding(.leading,5)
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(AppColors.appBackgroundColor).shadow(color: .black, radius: 10).opacity(0.5))
                    .padding(.top,20)
                }
              
                
                Spacer()
                Spacer()

//                HStack{
//                    Text("Ask me anything")
//                        .foregroundColor(.white)
//
//                    Spacer()
//
//                }
//
//                TextEditor(text: $description)
//                  .foregroundColor(AppColors.appBackgroundColor)
//                  .padding()
//                  .background(.white)
//                  .cornerRadius(10)
//                  .frame( height: 200)
//                  .navigationTitle("Your Query")
//                  .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                      .stroke(Color.white, lineWidth: 2)
//                  )
//
//                Spacer()
//
//                NavigationLink(destination: DetailScreen(), isActive: self.$toDetail, label: {
//                    HStack{
//                        Spacer()
//                        Text("Find Answer")
//                            .foregroundColor(AppColors.appBackgroundColor)
//
//                        Spacer()
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 10)
//                    .padding(.bottom,20)
//                })
             
                
            }
            .padding(.leading,20)
            .padding(.trailing,20)
            
        }
        .navigationBarHidden(true)
       

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
        "max_tokens": 128,
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


