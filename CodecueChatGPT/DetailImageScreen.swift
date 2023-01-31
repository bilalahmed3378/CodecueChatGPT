//
//  DetailImageScreen.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 30/01/2023.
//

import SwiftUI
import UIKit

struct DetailImageScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State var qureytext = ""
    @State private var showShareSheet = false
    var body: some View {
        ZStack{
            AppColors.appBackgroundColor
                .ignoresSafeArea(.all)
            
            
            
            VStack{
                // top bar
                HStack{
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                    
                    Text("Image Generation")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
//                    Image(systemName: "plus.app.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(.white)
//                        .frame(width: 20, height: 20)
                    
                    
                }
                .padding(.top,20)
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                        
                        ForEach(0...10, id : \.self){index in
                            
                            VStack{
                                
                                VStack{
                                    Image(uiImage: UIImage(named: AppImages.AiImage)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150 , height: 150)
                                        .cornerRadius(8)
                                        .padding(.top,20)
                                    
                                
                                        Button(action: {
                                            
                                        }, label: {
                                            Image(systemName: "square.and.arrow.up")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 24 , height: 24)
                                                .foregroundColor(.white)
                                                .padding(.top,5)
                                        })
                                       
                                        
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    
                    
                }
                
                HStack{
                    TextField("Open AI Waiting for your query", text: $qureytext)
                        .foregroundColor(AppColors.appBackgroundColor)
                        .padding(15)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    
                    Image(systemName: "paperplane")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .padding(.leading,5)
                    
                }
                
            }
            .padding(.leading,20)
            .padding(.trailing,20)
        }
        .navigationBarHidden(true)
    }
}


