//
//  TaskTimerDetail.swift
//  Chimpions
//
//  Created by Bruno De Vivo on 28/02/23.
//

import SwiftUI

struct TaskTimerDetail: View {
    
    @State var animationStatus: Double = 0
    @State var task: CTask
    
    var body: some View {
        
        ZStack{
            Color.black.ignoresSafeArea()
            
            ZStack{
                StreamShape(animationStatus: animationStatus)
                    .foregroundColor(.white)
                    .frame(height: 900)
                    .offset(y: 600) //TODO: dinamically assignation
                    .onAppear(){
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                            animationStatus = 1
                        }
                    }
                
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 30)
                    .offset(y: -495) //TODO: animation
                
                VStack{
                    HStack {
                        let offset: Double = 50
                        
                        ZStack {
                            Circle()
                                .frame(width: 100)
                                .offset(x: offset)
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: offset))
                                .offset(x: offset)
                            
                            Circle()
                                .frame(width: 30)
                                .offset(x: offset + 15, y: -75)
                            Circle()
                                .frame(width: 50)
                                .offset(x: offset + 55, y: -55)
                        }
                        
                        VStack (alignment: .leading){
                            Text(task.name)
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                            Text(durationConverter(durationInSeconds: task.duration))
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                        }
                        .offset(x: offset + 40, y: 15)
                        Spacer()
                    }
                }
                .offset(y: 310)
                
            }
            
        }
        
    }
}

func durationConverter(durationInSeconds: Int) -> String {
    
    let durationInMinutes: Int = durationInSeconds/60
    let durationInHours: Int = durationInMinutes/60
    let minuteOverHour: Int = durationInMinutes%60
    
    var result: String
    
    if durationInHours == 0{
        result = String(durationInMinutes) + "min"
    }
    else{
        if minuteOverHour == 0{
            result = String(durationInHours) + "h"
        }
        else{
            result = String(durationInHours) + "h " + String(minuteOverHour) + "min"
        }
    }
    if durationInSeconds<60{
        result = "< 1min"
    }
    
    return result
}

struct TaskTimerDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        let task = CTask(name: "Presentation", duration: 10, status: "something", timestamp: .now)
        
        TaskTimerDetail(task: task)
    }
}
