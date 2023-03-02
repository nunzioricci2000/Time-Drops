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
    @State var elapsedRatio: Double = 0
    @State var timer: Timer?
    @State var timerFinished = false
    
    var body: some View {
        
        ZStack{
            Color.black.ignoresSafeArea()
            
            ZStack{
                StreamShape(animationStatus: animationStatus)
                    .foregroundColor(.white)
                    .frame(height: 1000)
                    .offset(y: 600 * abs(elapsedRatio-1))
                    .onAppear(){
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                            animationStatus = 1
                        }
                    }
                
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 30)
                    .offset(y: -495)
                
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
                        if !timerFinished{
                            VStack (alignment: .leading){
                                Text(task.name ?? "Unknown")
                                    .font(.system(size: 24))
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                Text(durationConverter(durationInSeconds: Int(task.duration - task.elapsedTime)))
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                            }
                            .offset(x: offset + 40, y: 15)
                        }
                        Spacer()
                    }
                }
                .offset(y: 310)
                
                if timerFinished {
                    VStack(spacing: 15){
                        Text("You spilled")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                        Text(durationConverter(durationInSeconds: Int(task.duration)))
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                        Text("Need more drops?")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                    }
                    .transition(.opacity)
                }
                
            }
            
        }.onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                task.elapsedTime += 1
                withAnimation(.linear(duration: 1)){
                    if task.elapsedTime <= task.duration{
                        elapsedRatio = task.elapsedTime / task.duration
                    }
                }
                
                if task.elapsedTime >= task.duration{
                    timer.invalidate()
                    withAnimation(.linear(duration: 0.5)){
                        timerFinished = true
                    }
                }
            }
        }.onDisappear {
            try? PersistencyManager.shared.save(task: task)
            timer?.invalidate()
            timer = nil
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
    if durationInSeconds < 60{
        result = "< 1min"
    }
    
    return result
}

struct TaskTimerDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        TaskTimerDetail(task: PersistencyManager.preview { manager in
            let project = CProject(name: "Presentation")
            try? manager.save(project: project)
            try? manager.save(task: CTask(projectId: project.id, duration: 5))
        }.getAllTasks()[0])
    }
}
