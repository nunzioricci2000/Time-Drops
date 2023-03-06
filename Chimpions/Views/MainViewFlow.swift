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
    
    @State var projects: [CProject]  = {
        var result: [CProject] = []
        result.append(CProject(name: ""))
        result.append(contentsOf:  PersistencyManager.shared.getAllProjects())
        return result
    }()
    
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
                    Carousel(projects) { project in
                        ProjectButtonComponent(kind: project.name == "" ? .empty : .filledClosed, project: project, name: project.name)
                            .onClose {
                                if project.name == "" {
                                    try? PersistencyManager.shared.delete(project: project)
                                    let index = projects.firstIndex(where: { $0.id == project.id})
                                    if let index = index, index != 0 {
                                        projects.remove(at: index)
                                    }
                                    return
                                }
                            }
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
            print(projects)
        }.animation(.linear, value: projects)
    }
}
    
struct MainViewFlow_Previews: PreviewProvider {
    static var previews: some View {
        MainViewFlow()
            .environmentObject(PersistencyManager.preview)
    }
}
