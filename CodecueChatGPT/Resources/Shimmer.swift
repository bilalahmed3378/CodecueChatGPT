//
//  Shimmer.swift
//  CodecueChatGPT
//
//  Created by Bilal Ahmed on 01/02/2023.
//

import SwiftUI
import Shimmer

public struct ShimmerView : View {
    
    
    let cornerRadius : CGFloat
    let fill : Color

    
    
    public init(cornerRadius : CGFloat , fill : Color) {
        self.cornerRadius = cornerRadius
        self.fill = fill
    }
    
    public var body: some View {
        
        RoundedRectangle(cornerRadius: self.cornerRadius)
            .shimmering(active: true, duration: 1.0, bounce: false)
            .foregroundColor(self.fill)
    }
}



