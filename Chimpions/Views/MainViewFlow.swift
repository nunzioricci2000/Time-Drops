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
        ZStack{
            StreamComponent()
                .offset(y: 50)
            
            VStack {
                
                //Date and "Your Flow"
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
                    
                    
                }
                .padding(.top, 10)
                
                Spacer()
                
                //Tasks Place holders
                HStack {
                    let taskPlaceholder = ZStack{
                        squareAnimation(color: .gray)
                        Text("Task")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                    }
                    
                    taskPlaceholder
                        .offset(x: -126)
                    taskPlaceholder
                    taskPlaceholder
                        .offset(x: 126)
                }
                .offset(y: 20)
                
                Spacer()
                
                //Lake placeholder and Task Hours counter
                VStack {
                    Rectangle()
                        .frame(width: 350, height: 200)
                    .cornerRadius(30)
                
                HStack{
                    ZStack{
                        squareAnimation(color: .gray)
                            .scaleEffect(0.8)
                        Text("0")
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                    }
                    Spacer()
                }
                .padding(.leading)
                    
                }
                .offset(y: 50)
                
                Spacer()
                
                //Strange button
                ZStack {
                    Circle()
                        .frame(width: 100)
                    squareAnimation(color: .white)
                        .scaleEffect(0.6)
                    
                }
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
}
