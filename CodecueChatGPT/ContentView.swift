//
//  ContentView.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 30/01/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            HomeScreen()

        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let widthBlockSize = (UIScreen.main.bounds.size.width/100)
    static let screenHeight = UIScreen.main.bounds.size.height
    static let heightBlockSize = (UIScreen.main.bounds.size.height/100)
    static let screenSize = UIScreen.main.bounds.size
}
