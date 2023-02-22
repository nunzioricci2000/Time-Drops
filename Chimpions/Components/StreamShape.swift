//
//  StreamShape.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 22/02/23.
//

import SwiftUI

private struct StreamShape: Shape {
    var animationStatus: Double = 0
    
    var animatableData: Double {
        get { animationStatus }
        set { animationStatus = newValue }
    }
    
    func shape(in rect: CGRect) -> Path {
        let widthMultplier = rect.width / 389.85
        var path = Path()
        path.move(to: CGPoint(x: rect.origin.x + 0 * widthMultplier, y: rect.origin.y + 23.9))
        path.addCurve(to: CGPoint(x: rect.origin.x + 93.86 * widthMultplier, y: rect.origin.y + 5.98), control1: CGPoint(x: rect.origin.x + 13.41 * widthMultplier, y: rect.origin.y + 5.27), control2: CGPoint(x: rect.origin.x + 35.86 * widthMultplier, y: rect.origin.y + -8.36))
        path.addCurve(to: CGPoint(x: rect.origin.x + 266.19 * widthMultplier, y: rect.origin.y + 50.78), control1: CGPoint(x: rect.origin.x + 166.37 * widthMultplier, y: rect.origin.y + 23.9), control2: CGPoint(x: rect.origin.x + 234.87 * widthMultplier, y: rect.origin.y + 50.78))
        path.addCurve(to: CGPoint(x: rect.origin.x + 389.85 * widthMultplier, y: rect.origin.y + 5.98), control1: CGPoint(x: rect.origin.x + 291.02 * widthMultplier, y: rect.origin.y + 50.78), control2: CGPoint(x: rect.origin.x + 366.01 * widthMultplier, y: rect.origin.y + 43.93))
        path.addLine(to: CGPoint(x: rect.origin.x + 389.85 * widthMultplier, y: rect.origin.y + 193.21))
        path.addCurve(to: CGPoint(x: rect.origin.x + 389.85 * widthMultplier, y: rect.origin.y + 195.73), control1: CGPoint(x: rect.origin.x + 390.19 * widthMultplier, y: rect.origin.y + 194.75), control2: CGPoint(x: rect.origin.x + 389.85 * widthMultplier, y: rect.origin.y + 195.73))
        path.addLine(to: CGPoint(x: rect.origin.x + 389.85 * widthMultplier, y: rect.origin.y + 193.21))
        path.addCurve(to: CGPoint(x: rect.origin.x + 355.08 * widthMultplier, y: rect.origin.y + 177.28), control1: CGPoint(x: rect.origin.x + 388.95 * widthMultplier, y: rect.origin.y + 189.22), control2: CGPoint(x: rect.origin.x + 383.4 * widthMultplier, y: rect.origin.y + 181.47))
        path.addCurve(to: CGPoint(x: rect.origin.x + 229.44 * widthMultplier, y: rect.origin.y + 217.34), control1: CGPoint(x: rect.origin.x + 315.85 * widthMultplier, y: rect.origin.y + 171.48), control2: CGPoint(x: rect.origin.x + 283.57 * widthMultplier, y: rect.origin.y + 209.43))
        path.addCurve(to: CGPoint(x: rect.origin.x + 67.54 * widthMultplier, y: rect.origin.y + 195.73), control1: CGPoint(x: rect.origin.x + 175.31 * widthMultplier, y: rect.origin.y + 225.25), control2: CGPoint(x: rect.origin.x + 135.08 * widthMultplier, y: rect.origin.y + 192.04))
        path.addCurve(to: CGPoint(x: rect.origin.x + 0 * widthMultplier, y: rect.origin.y + 253), control1: CGPoint(x: rect.origin.x + 13.51 * widthMultplier, y: rect.origin.y + 198.68), control2: CGPoint(x: rect.origin.x + 6.29 * widthMultplier, y: rect.origin.y + 243.86))
        path.addLine(to: CGPoint(x: rect.origin.x + 0 * widthMultplier, y: rect.origin.y + 23.9))
        return path
    }
    
    func path(in rect: CGRect) -> Path {
        let rect1 = CGRect(origin: .init(x: -rect.size.width * animationStatus, y: 0),
                           size: rect.size)
        let rect2 = CGRect(origin: .init(x: rect.size.width-rect.size.width * animationStatus, y: 0),
                           size: rect.size)
        var path = Path()
        path.addPath(shape(in: rect1))
        path.addPath(shape(in: rect2))
        return path
    }
}

struct StreamComponent: View {
    @State var animationStatus = 0.0
    
    var body: some View {
        StreamShape(animationStatus: animationStatus)
            .opacity(0.15)
            .padding(.top, 68)
            .animation(.linear(duration: 2).repeatForever(autoreverses: false),
                       value: animationStatus)
            .onAppear {
                animationStatus = 1
            }
    }
}

struct StreamShape_Previews: PreviewProvider {
    static var previews: some View {
        StreamComponent()
    }
}
