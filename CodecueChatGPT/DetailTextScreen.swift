//
//  DetailScreen.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 30/01/2023.
//

import SwiftUI
import UIKit

struct QuestionAnswer : Hashable {
    let question : String
    var answer : Choice
}

struct DetailTextScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State var qureytext = ""
    @State private var copied = false
    @State private var dummyText = "dfdkjhgdflkjghdfgkljdhfgklfhsgkl"
    @State private var showShareSheet : Bool = false
    @State private var textToShare = "gldhjflgkjhflskgjdhfglkdjfhgldkf gfdgjhdfglkfhglkdfjh!"
    @State private var prompt = "Hello, how are you today?"
    @State private var generatedText = ""
    @State private var textCopy : String = ""

    
    @State private var isLoading = false
    @State private var showText : Bool = false
    @State var messageList : [QuestionAnswer] = []
    
//    @EnvironmentObject var adVM: AdsViewModel


    var body: some View {
        
        ZStack{
            AppColors.appBackgroundColor
                .ignoresSafeArea(.all)
            
            
           
                VStack{
                    // top bar
                    HStack{
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
//                            self.adVM.showInterstitial = true

                        }, label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.white)
                        })
                        
                        Spacer()
                        
                        Text("AI Chat")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
    //                    Image(systemName: "plus.app.fill")
    //                        .resizable()
    //                        .aspectRatio(contentMode: .fit)
    //                        .foregroundColor(.white)
    //                        .frame(width: 20, height: 20)
                        
                        
                    }
                    .padding(.top,20)
                    .padding(.bottom,10)
                    
//                    if(self.isLoading){
//                        ScrollView(.vertical , showsIndicators: false){
//
//                            ForEach(0...10, id:\.self){ index in
//
//                                ShimmerView(cornerRadius: 10, fill: .gray.opacity(0.5))
//                                    .frame(width: (UIScreen.screenWidth-40), height: 140)
//                                    .padding(.top,20)
//
//
//                            }
//
//                        }
//                        .clipped()
//                    }
                    
                                        
                 
                        
                        if(!self.messageList.isEmpty){
                            ScrollView(.vertical, showsIndicators: false){
                                
                                LazyVStack{
                                    
                                    LazyVStack{
                                        ForEach(self.messageList.indices, id:\.self){index in
                                            
                                            Message(questionAnswer: self.messageList[index])
                                              
                                                
                                            
                                        }
                                    }
                                     
                                }
                                .rotationEffect(.degrees(180))
                                
                                
                            }
                            .rotationEffect(.degrees(180))
                        }
                        else{
                            Spacer()
                            Image(uiImage: UIImage(named: AppImages.appLogo)!)
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(height: 200)
                                .padding(.bottom,30)
                            Spacer()
                        }
                        
                        
                    
                  
                    
                    HStack{
                        
                        TextField("Type Something", text: $qureytext)
                            .foregroundColor(AppColors.appBackgroundColor)
                            .padding(15)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        
                        
                        if isLoading {
                           ProgressView()
                                .foregroundColor(.white)
                                .padding(.leading,5)
                        }
                        else{
                            
                            
                            if(self.qureytext != ""){
                                Button(action: generate, label: {
                                    
                                    
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.white)
                                        .padding(.leading,5)
                                        .rotationEffect(self.qureytext != "" ? .degrees(0) : .degrees(40))
                                       
                                })
                                .disabled(isLoading)
                            }
                               
                            
                            else{
                                Image(systemName: "paperplane")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                                    .padding(.leading,5)
                                    .rotationEffect(self.qureytext != "" ? .degrees(0) : .degrees(40))
                            }
                              
                        }
                        
                    }
                    .padding(.bottom,5)
                    
//                    BannerWrapper().frame(height: 50)

                    
                    
                    
                    
                }
                .padding(.leading,20)
                .padding(.trailing,20)
            
            
        }
        .navigationBarHidden(true)
        
        
    }
    
    func generate() {
        isLoading = true
        withAnimation{
            self.messageList.append(QuestionAnswer(question: self.qureytext, answer: Choice(text: "", finish_reason: "", index: 0)))

        }
        generateText(prompt: qureytext) { result in
            switch result {
            case .success(let text):
                withAnimation{
                    self.messageList[(self.messageList.count - 1)].answer = Choice(text: text, finish_reason: "", index: nil)

                }
            case .failure(let error):
                withAnimation{
                    self.messageList[(self.messageList.count - 1)].answer = Choice(text: error.localizedDescription, finish_reason: "", index: nil)
                }
            }
            self.isLoading = false
        }
        self.qureytext = ""
    }
}

struct Message : View{
    
    @State private var copied = false
    @State private var showShareSheet : Bool = false

    @State private var generatedText = ""
    
    let questionAnswer : QuestionAnswer
    


    var body: some View{
        
       
        VStack{
            
            HStack{
                Spacer()
                HStack{
                    
                    Text(questionAnswer.question)
                        .foregroundColor(.white)
                    
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1).foregroundColor(.white))
                .padding(.top,10)
            }
            
            if(self.questionAnswer.answer.text != ""){
                VStack{
                    
                    HStack{
                        
                        
                        Text("\(self.questionAnswer.answer.text ?? "")")
                            .foregroundColor(AppColors.appBackgroundColor)
                        
                        Spacer()
                        
                    }
                    
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            self.showShareSheet = true
                        }, label: {
                         
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 16 , height: 16)
                                .foregroundColor(AppColors.appBackgroundColor)
                        })
                    
                        
                        Spacer()
                        
                        Button(action: {
                            UIPasteboard.general.string = self.questionAnswer.answer.text ?? ""
                            self.copied = true
                        }, label: {
                            HStack{
                                Image(systemName: "doc.on.doc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 16 , height: 16)
                                    .foregroundColor(AppColors.appBackgroundColor)
                                
                            }
                            
                            
                        })
                        .alert(isPresented: $copied) {
                            Alert(title: Text("Copied"), message: Text("The text has been copied to the clipboard."), dismissButton: .default(Text("OK")))
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.top,10)
                    .padding(.bottom,5)
                    
                    
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .padding(.top,10)
            }
            
        }
        .sheet(isPresented: $showShareSheet) {
            ActivityView(activityItems: [self.questionAnswer.answer.text ?? ""])
                }
       
    }
}



struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}




