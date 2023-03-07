//
//  GraphicsView.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 22/02/23.
//

import SwiftUI

struct GraphicsView: View {
    
    
    var body: some View {
        ZStack {
            Color.black
            Text("Prova")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.white)
            VStack(spacing: 0) {
                Color.black
                Color.white
            }.blendMode(.exclusion)
        }.compositingGroup()
    }
}

struct GraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        GraphicsView()
    }
}
