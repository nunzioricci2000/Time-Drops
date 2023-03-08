//
//  TaskButtonComponent.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 07/03/23.
//

import SwiftUI

struct TaskButtonComponent: View {
    @State var task: CTask
    
    var duration: String {
        durationConverter(durationInSeconds: Int(task.duration))
    }
    
    var body: some View {
        VStack {
            ZStack {
                Image("TaskPond")
                Image(systemName: "play.fill")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
            Text(task.name!)
                .font(.system(size: 25, design: .rounded))
                .fontWeight(.semibold)
            Text(duration)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
    }
}

struct TaskButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TaskButtonComponent(task: PersistencyManager.preview.getAllTasks()[0])
                .padding(100)
        }
            .background(.black)
            .environmentObject(PersistencyManager.preview)
    }
}
