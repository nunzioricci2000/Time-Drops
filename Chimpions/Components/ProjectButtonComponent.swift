//
//  ProjectButtonComponent.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 02/03/23.
//

import SwiftUI

struct ProjectButtonComponent: View {
    @State var kind: Kind = .empty
    @Namespace var ns
    @State var project : CProject?
    @State var onClose: () -> () = { }
    @State var onTaskAdd: (TimeInterval) -> () = { _ in }
    @State var name: String = ""
    
    var nameIsValid: Bool {
        return name != ""
    }
    
    @State var task1Offset: CGVector = .zero
    @State var task2Offset: CGVector = .zero
    @State var task3Offset: CGVector = .zero
    
    var mainFrame: CGSize {
        switch kind {
        case .empty:
            return CGSize(width: 132, height: 121)
        case .editing:
            return CGSize(width: 198, height: 237)
        case .filledClosed:
            return CGSize(width: 116, height: 102)
        }
    }
    
    var mainCircleRect: CGRect {
        switch kind {
        case .empty:
            return CGRect(x: 0 + 91.67 / 2,
                          y: 29.33 + 91.67 / 2,
                          width: 91.67,
                          height: 91.67)
        case .editing:
            return CGRect(x: 43 + 91.67 / 2,
                          y: 47 + 91.67 / 2,
                          width: 91.67,
                          height: 91.67)
        case .filledClosed:
            return CGRect(x: 22 + 50 / 2,
                          y: 16 + 50 / 2,
                          width: 50,
                          height: 50)
        }
    }
    
    var addCircle1Rect: CGRect {
        switch kind {
        case .empty:
            return CGRect(x: 53.17 + 22.92 / 2,
                          y: 0 + 22.92 / 2,
                          width: 22.92,
                          height: 22.92)
        case .editing:
            return mainCircleRect
        case .filledClosed:
            return CGRect(x: 51 + 12.5 / 2,
                          y: 0 + 12.5 / 2,
                          width: 12.5,
                          height: 12.5)
        }
    }
    
    var addCircle2Rect: CGRect {
        switch kind {
        case .empty:
            return CGRect(x: 86.17 + 45.83 / 2,
                          y: 5.5 + 45.83 / 2,
                          width: 45.83,
                          height: 45.83)
        case .editing:
            return mainCircleRect
        case .filledClosed:
            return CGRect(x: 69 + 25 / 2,
                          y: 3 + 25 / 2,
                          width: 25,
                          height: 25)
        }
    }
    
    var focusCircle1Rect: CGRect {
        switch kind {
        case .empty:
            return mainCircleRect
        case .editing:
            return CGRect(origin: .init(x: 0 + 35 / 2,
                                        y: 114 + 35 / 2) + task1Offset,
                          size: .init(width: 35, height: 35))
        case .filledClosed:
            return mainCircleRect
        }
    }
    
    var focusCircle2Rect: CGRect {
        switch kind {
        case .empty:
            return mainCircleRect
        case .editing:
            return CGRect(origin: .init(x: 143 + 55 / 2,
                                        y: 90 + 55 / 2) + task2Offset,
                          size: .init(width: 55, height: 55))
        case .filledClosed:
            return mainCircleRect
        }
    }
    
    var focusCircle3Rect: CGRect {
        switch kind {
        case .empty:
            return mainCircleRect
        case .editing:
            return CGRect(origin: .init(x: 65 + 70 / 2,
                                        y: 145 + 70 / 2) + task3Offset,
                          size: .init(width: 70, height: 70))
        case .filledClosed:
            return mainCircleRect
        }
    }
    
    func circle(_ rect: CGRect) -> some View {
        Circle()
            .frame(width: rect.width, height: rect.height)
            .position(rect.origin)
    }
    
    var mainCircle: some View {
        circle(mainCircleRect)
    }
    
    var addCircle1: some View {
        circle(addCircle1Rect)
    }
    
    var addCircle2: some View {
        circle(addCircle2Rect)
    }
    
    func focusGesture() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        nameIsValid ? DragGesture()
            .onChanged { gesture in
                
            }.onEnded { gesture in
                
            } : DragGesture()
            .onChanged { _ in }
            .onEnded { _ in }
    }
    
    var focusCircle1: some View {
        circle(focusCircle1Rect)
            .gesture(focusGesture())
    }
    
    var focusCircle2: some View {
        circle(focusCircle2Rect)
    }
    
    var focusCircle3: some View {
        circle(focusCircle3Rect)
    }
    
    var plusSign: some View {
        Image(systemName: "plus")
            .font(.system(size: 25, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .rotationEffect( kind == .editing ? .degrees(45) : .zero)
            .frame(width: mainCircleRect.width, height: mainCircleRect.height)
            .position(mainCircleRect.origin)
    }
    
    var button: some View {
        ZStack {
            mainCircle
            plusSign
        }
        .onTapGesture {
            withAnimation(.spring()) {
                clickButton()
            }
        }
    }
    
    @ViewBuilder
    var labels: some View {
        if nameIsValid, kind == .editing {
            Group {
                Text("15 m")
                    .position(x: 1 + 33 / 2,
                              y: 154 + 20 / 2)
                Text("1h")
                    .position(x: 91 + 19 / 2,
                              y: 217 + 20 / 2)
                Text("30 m")
                    .position(x: 156 + 36 / 2,
                              y: 149 + 20 / 2)
            }.font(.system(size: 15, weight: .bold, design: .rounded))
                .transition(.opacity)
        }
    }
    
    @ViewBuilder
    var projectName: some View {
        if kind != .empty {
            VStack {
                if kind == .filledClosed {
                    Color.clear
                    Text(name)
                        .matchedGeometryEffect(id: "projectName", in: ns, anchor: .leading)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
                if kind == .editing {
                    TextField("Project name", text: $name)
                        .matchedGeometryEffect(id: "projectName", in: ns, anchor: .leading)
                        .font(.system(size: 32, weight: .bold ,design: .rounded))
                    Spacer()
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
                addCircle1
                addCircle2
                focusCircle1
                .onTapGesture {
                    if nameIsValid {
                        addTask1()
                    }
                }
                focusCircle2
                .onTapGesture {
                    if nameIsValid {
                        addTask2()
                    }
                }
                focusCircle3
                .onTapGesture {
                    if nameIsValid {
                        addTask3()
                    }
                }
            button
            projectName
            labels
        }.frame(width: mainFrame.width, height: mainFrame.height)
            /*.onChange(of: name) { newValue in
                project?.name = name
                if let project = project {
                    do {
                        try PersistencyManager.shared.save(project: project)
                        print("Project saved: \(project)")
                    } catch {
                        print("Some trouble during project saving: Project\(project) \n Error: \(error)")
                    }
                }
            }*/
    }
    
    func clickButton() {
        if kind == .empty {
            project = CProject(name: "")
            kind = .editing
            return
        }
        if kind == .editing {
            if nameIsValid {
                var foundHomonym = false
                for tempProject in PersistencyManager.shared.getAllProjects(){
                    if tempProject.name == name {
                        if tempProject.id != project?.id {
                            foundHomonym = true
                        }
                    }
                }
                if !foundHomonym {
                    project?.name = name
                    try? PersistencyManager.shared.save(project: project!)
                    kind = .filledClosed
                }
                else{
                    kind = .empty
                    name = project?.name ?? ""
                }
            } else {
                try? PersistencyManager.shared.delete(project: project!)
                kind = .empty
            }
            return
        }
        if kind == .filledClosed {
            kind = .editing
        }
    }
    
    func addTask1() {
        withAnimation(.easeInOut(duration: 0.5)) {
            task1Offset = .init(dx: 0, dy: 350)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            task1Offset = .init(dx: 100, dy: -40)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            withAnimation(.easeInOut(duration: 0.4)) {
                task1Offset = .zero
            }
        }
    }
    
    func addTask2() {
        withAnimation(.easeInOut(duration: 0.5)) {
            task2Offset = .init(dx: 0, dy: 350)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            task2Offset = .init(dx: -80, dy: -30)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            withAnimation(.easeInOut(duration: 0.4)) {
                task2Offset = .zero
            }
        }
    }
    
    func addTask3() {
        withAnimation(.easeInOut(duration: 0.5)) {
            task3Offset = .init(dx: 0, dy: 350)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            task3Offset = .init(dx: -10, dy: -90)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            withAnimation(.easeInOut(duration: 0.4)) {
                task3Offset = .zero
            }
        }
    }
    
    func onClose(_ onClose: @escaping () -> ()) -> Self {
        self.onClose = onClose
        return self
    }
    
    enum Kind {
        case empty, filledClosed, editing
    }
}

struct ProjectButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProjectButtonComponent()
    }
}
