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
    
    func stream(in rect: CGRect) -> Path {
        let widthMultplier = rect.width / 389.85
        let offset = CGVector(dx: rect.origin.x, dy: rect.origin.y)
        var path = Path()
        path.move(to: CGPoint(x: 111.26 * widthMultplier, y: 38.57) + offset)
        path.addCurve(to: CGPoint(x: 0 * widthMultplier, y: 12.58) + offset,
                      control1: CGPoint(x: 53.45 * widthMultplier, y: 24.53) + offset,
                      control2: CGPoint(x: 21.76 * widthMultplier, y: -22.14) + offset)
        path.addLine(to: CGPoint(x: 0 * widthMultplier, y: 203.9) + offset)
        path.addCurve(to: CGPoint(x: 143.89 * widthMultplier, y: 192.9) + offset,
                      control1: CGPoint(x: 41.54 * widthMultplier, y: 239.35) + offset,
                      control2: CGPoint(x: 90.05 * widthMultplier, y: 195.79) + offset)
        path.addCurve(to: CGPoint(x: 273.66 * widthMultplier, y: 226.1) + offset,
                      control1: CGPoint(x: 211.2 * widthMultplier, y: 189.29) + offset,
                      control2: CGPoint(x: 219.71 * widthMultplier, y: 233.84) + offset)
        path.addCurve(to: CGPoint(x: 355.36 * widthMultplier, y: 186.87) + offset,
                      control1: CGPoint(x: 327.6 * widthMultplier, y: 218.35) + offset,
                      control2: CGPoint(x: 327.85 * widthMultplier, y: 186.87) + offset)
        path.addCurve(to: CGPoint(x: 390 * widthMultplier, y: 203.9) + offset,
                      control1: CGPoint(x: 378.29 * widthMultplier, y: 186.87) + offset,
                      control2: CGPoint(x: 390 * widthMultplier, y: 203.9) + offset)
        path.addLine(to: CGPoint(x: 390 * widthMultplier, y: 12.09) + offset)
        path.addCurve(to: CGPoint(x: 254.16 * widthMultplier, y: 30.68) + offset,
                      control1: CGPoint(x: 366.24 * widthMultplier, y: 49.25) + offset,
                      control2: CGPoint(x: 278.91 * widthMultplier, y: 30.68) + offset)
        path.addCurve(to: CGPoint(x: 111.26 * widthMultplier, y: 38.57) + offset,
                      control1: CGPoint(x: 222.95 * widthMultplier, y: 30.68) + offset,
                      control2: CGPoint(x: 183.52 * widthMultplier, y: 56.11) + offset)
        return path
    }
    
    func shape(in rect: CGRect) -> Path {
        let widthMultplier = rect.width / 389.85
        var path = Path()
        path.move(to: CGPoint(x: rect.origin.x + 0 * widthMultplier * widthMultplier, y: rect.origin.y + 23.9))
        path.addCurve(to: CGPoint(x: rect.origin.x + 93.86 * widthMultplier * widthMultplier, y: rect.origin.y + 5.98), control1: CGPoint(x: rect.origin.x + 13.41 * widthMultplier * widthMultplier, y: rect.origin.y + 5.27), control2: CGPoint(x: rect.origin.x + 35.86 * widthMultplier * widthMultplier, y: rect.origin.y + -8.36))
        path.addCurve(to: CGPoint(x: rect.origin.x + 266.19 * widthMultplier * widthMultplier, y: rect.origin.y + 50.78), control1: CGPoint(x: rect.origin.x + 166.37 * widthMultplier * widthMultplier, y: rect.origin.y + 23.9), control2: CGPoint(x: rect.origin.x + 234.87 * widthMultplier * widthMultplier, y: rect.origin.y + 50.78))
        path.addCurve(to: CGPoint(x: rect.origin.x + 389.85 * widthMultplier * widthMultplier, y: rect.origin.y + 5.98), control1: CGPoint(x: rect.origin.x + 291.02 * widthMultplier * widthMultplier, y: rect.origin.y + 50.78), control2: CGPoint(x: rect.origin.x + 366.01 * widthMultplier * widthMultplier, y: rect.origin.y + 43.93))
        path.addLine(to: CGPoint(x: rect.origin.x + 389.85 * widthMultplier * widthMultplier, y: rect.origin.y + 193.21))
        path.addCurve(to: CGPoint(x: rect.origin.x + 389.85 * widthMultplier * widthMultplier, y: rect.origin.y + 195.73), control1: CGPoint(x: rect.origin.x + 390.19 * widthMultplier * widthMultplier, y: rect.origin.y + 194.75), control2: CGPoint(x: rect.origin.x + 389.85 * widthMultplier * widthMultplier, y: rect.origin.y + 195.73))
        path.addLine(to: CGPoint(x: rect.origin.x + 389.85 * widthMultplier * widthMultplier, y: rect.origin.y + 193.21))
        path.addCurve(to: CGPoint(x: rect.origin.x + 355.08 * widthMultplier * widthMultplier, y: rect.origin.y + 177.28), control1: CGPoint(x: rect.origin.x + 388.95 * widthMultplier * widthMultplier, y: rect.origin.y + 189.22), control2: CGPoint(x: rect.origin.x + 383.4 * widthMultplier * widthMultplier, y: rect.origin.y + 181.47))
        path.addCurve(to: CGPoint(x: rect.origin.x + 229.44 * widthMultplier * widthMultplier, y: rect.origin.y + 217.34), control1: CGPoint(x: rect.origin.x + 315.85 * widthMultplier * widthMultplier, y: rect.origin.y + 171.48), control2: CGPoint(x: rect.origin.x + 283.57 * widthMultplier * widthMultplier, y: rect.origin.y + 209.43))
        path.addCurve(to: CGPoint(x: rect.origin.x + 67.54 * widthMultplier * widthMultplier, y: rect.origin.y + 195.73), control1: CGPoint(x: rect.origin.x + 175.31 * widthMultplier * widthMultplier, y: rect.origin.y + 225.25), control2: CGPoint(x: rect.origin.x + 135.08 * widthMultplier * widthMultplier, y: rect.origin.y + 192.04))
        path.addCurve(to: CGPoint(x: rect.origin.x + 0 * widthMultplier * widthMultplier, y: rect.origin.y + 253), control1: CGPoint(x: rect.origin.x + 13.51 * widthMultplier * widthMultplier, y: rect.origin.y + 198.68), control2: CGPoint(x: rect.origin.x + 6.29 * widthMultplier * widthMultplier, y: rect.origin.y + 243.86))
        path.addLine(to: CGPoint(x: rect.origin.x + 0 * widthMultplier * widthMultplier, y: rect.origin.y + 23.9))
        return path
    }
    
    func path(in rect: CGRect) -> Path {
        let rect1 = CGRect(origin: .init(x: -rect.size.width * animationStatus, y: 0),
                           size: rect.size)
        let rect2 = CGRect(origin: .init(x: rect.size.width-rect.size.width * animationStatus, y: 0),
                           size: rect.size)
        var path = Path()
        path.addPath(stream(in: rect1))
        path.addPath(stream(in: rect2))
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
