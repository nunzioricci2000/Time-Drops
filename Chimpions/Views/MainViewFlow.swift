//
//  MainViewFlow.swift
//  Chimpions
//
//  Created by Bruno De Vivo on 23/02/23.
//

import SwiftUI

struct MainViewFlow: View {
    
    var dayMonth = {
        let date = Date()
        var formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }()
    var dayNameYear = {
        let date = Date()
        var formatter = DateFormatter()
        formatter.dateFormat = "EEEE yyyy"
        return formatter.string(from: date)
    }()
    
    @State var startRotation = false
    @State var taskSelectedOpen = false
    
    func squareAnimation(color: Color) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .rotationEffect(Angle(degrees: startRotation ? 360 : 0))
                .foregroundColor(color)
                .opacity(0.2)
            Rectangle()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .rotationEffect(Angle(degrees: startRotation ? 387 : 27))
                .foregroundColor(color)
                .opacity(0.2)
            Rectangle()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .rotationEffect(Angle(degrees: startRotation ? 58 : 418))
                .foregroundColor(color)
                .opacity(0.2)
        }
    }
    
    var body: some View {
        VStack{
            VStack{
                HStack {
                    Spacer()
                    VStack{
                        HStack{
                            Text(dayMonth)
                                .font(.system(size: 44))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                        }
                        HStack{
                            Text(dayNameYear)
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                        }
                    }
                    .padding(.trailing)
                }
                
                HStack {
                    Text("Your Flow")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                    Spacer()
                }
                .padding(.leading)
                ZStack {
                    StreamComponent()
                        .opacity(0.15)
                    Carousel {
                        ProjectButtonComponent()
                        ProjectButtonComponent()
                        ProjectButtonComponent()
                    }
                }.frame(height: 250)
                    .offset(y: -25)
                
            }
            .padding(.top, 10)
            
            Spacer(minLength: 100)
            ZStack(alignment: .top) {
                StreamComponent()
                    .ignoresSafeArea()
                HStack {
                    Text("Today")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Spacer()
                }.offset(y: 30)
            }
            .offset(y: 50)
            
        }
        .onAppear(){
            withAnimation(.linear(duration: 18.0).repeatForever(autoreverses: false)){
                startRotation.toggle()
            }
        }
    }
}
    
struct MainViewFlow_Previews: PreviewProvider {
    static var previews: some View {
        MainViewFlow()
    }
}
