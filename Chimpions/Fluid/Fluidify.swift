//
//  FluidView.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 23/02/23.
//

import SwiftUI

struct Fluidify<Content: View>: View {
    @ViewBuilder var content: () -> Content
    var background: AnyView?
    var backgroundAlignment: Alignment = .center
    
    var body: some View {
        ZStack(alignment: backgroundAlignment) {
            if let background = background {
                background
            }
            ZStack {
                content()
                .foregroundColor(.black)
                .blur(radius: 5)
                .zIndex(0)
                Rectangle()
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                    .blendMode(.colorBurn)
                    .zIndex(1)
                Rectangle()
                    .foregroundColor(.white)
                    .blendMode(.colorDodge)
                    .zIndex(2)
            }.compositingGroup()
                .blendMode(.multiply)
        }.compositingGroup()
    }
    
    func background(alignment: Alignment = .center, @ViewBuilder content: () -> some View) -> some View {
        var newView = self
        newView.background = AnyView(content())
        newView.backgroundAlignment = alignment
        return newView
    }
}
