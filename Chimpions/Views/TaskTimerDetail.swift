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
    @Binding var displayTimer: Bool
    
    var body: some View {
        
        ZStack{
            Color.black.ignoresSafeArea()
            
            ZStack{
                ZStack(alignment: .topLeading) {
                    if !timerFinished {
                        Text("X")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .position(x: 40, y: 140)
                            .onTapGesture {
                                displayTimer.toggle()
                            }
                    }
                    StreamComponent(animationStatus: animationStatus)
                        .foregroundColor(.white)
                        .frame(height: 1000)
                        .offset(y: 600 * abs(elapsedRatio-1))
                        .onAppear(){
                            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                                animationStatus = 1
                            }
                        }.blendMode(.exclusion)
                }.compositingGroup()
                
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 30)
                    .offset(y: -495)
                
                VStack{
                    HStack {
                        ZStack {
                            
                            Circle()
                                .frame(width: 30)
                                .offset(x: timerFinished ? 0 : 15, y: timerFinished ? 0 : -75)
                            Circle()
                                .frame(width: 50)
                                .offset(x: timerFinished ? 0 : 55, y: timerFinished ? 0 : -55)
                            
                            Circle()
                                .frame(width: 100)
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                                .rotationEffect(.degrees(timerFinished ? -45 : 0))
                            
                        }
                        .offset(x: timerFinished ? 293/2 : 50)
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
                        .offset(x: 90, y: 15)
                        .opacity(timerFinished ? 0 : 1)
                        Spacer()
                    }
                }
                .offset(y: 310)
                
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
                    .opacity(timerFinished ? 1 : 0)
                
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
            try? manager.save(task: CTask(projectId: project.id, duration: 20))
        }.getAllTasks()[0], displayTimer: .constant(true))
    }
}
