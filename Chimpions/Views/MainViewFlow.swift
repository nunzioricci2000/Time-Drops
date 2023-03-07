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
    
    @State var projects: [CProject]  = {
        var result: [CProject] = []
        result.append(CProject(name: ""))
        result.append(contentsOf:  PersistencyManager.shared.getAllProjects())
        return result
    }()
    
    @State var tasks: [CTask] = {
        var result: [CTask] = []
        result.append(contentsOf:  PersistencyManager.shared.getAllTasks())
        return result
    }()
    
    @State var displayTimer: Bool = false
    @State var selectedTask: CTask!
    
    var body: some View {
        if displayTimer {
            TaskTimerDetail(task: selectedTask, displayTimer: $displayTimer)
                .transition(.move(edge: .bottom))
                .onAppear {
                    print(tasks[0])
                }
        } else {
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
                        Carousel(projects) { project in
                            ProjectButtonComponent(kind: project.name == "" ? .empty : .filledClosed, project: project, onTaskAdd: { interval in
                                let task = CTask(projectId: project.id, duration: interval)
                                tasks.append(task)
                                try? PersistencyManager.shared.save(task: task)
                            }, name: project.name)
                        }
                    }
                    .frame(height: 250)
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
                    Carousel(tasks) { task in
                        TaskButtonComponent(task: task)
                            .onTapGesture {
                                selectedTask = task
                                displayTimer.toggle()
                            }
                    }
                }
                .offset(y: 50)
                
            }
            .onAppear(){
                print(projects)
            }.animation(.linear, value: projects)
                .transition(.move(edge: .top))
        }
    }
}
    
struct MainViewFlow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MainViewFlow()
                .environmentObject(PersistencyManager.preview)
        }
    }
}
