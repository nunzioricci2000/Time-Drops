//
//  ProjectButtonComponent.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 02/03/23.
//

import SwiftUI

struct ProjectButtonComponent: View {
    @State var kind: Kind = .add
    @Namespace var ns
    @State var project: CProject?
    
    @State var name: String = ""
    
    var isValid: Bool {
        return name != ""
    }
    
    var mainFrame: CGSize {
        switch kind {
        case .add:
            return CGSize(width: 132, height: 121)
        case .active:
            return CGSize(width: 198, height: 237)
        case .normal:
            return CGSize(width: 116, height: 102)
        }
    }
    
    var mainCircleRect: CGRect {
        switch kind {
        case .add:
            return CGRect(x: 0 + 91.67 / 2,
                          y: 29.33 + 91.67 / 2,
                          width: 91.67,
                          height: 91.67)
        case .active:
            return CGRect(x: 43 + 91.67 / 2,
                          y: 47 + 91.67 / 2,
                          width: 91.67,
                          height: 91.67)
        case .normal:
            return CGRect(x: 22 + 50 / 2,
                          y: 16 + 50 / 2,
                          width: 50,
                          height: 50)
        }
    }
    
    var addCircle1Rect: CGRect {
        switch kind {
        case .add:
            return CGRect(x: 53.17 + 22.92 / 2,
                          y: 0 + 22.92 / 2,
                          width: 22.92,
                          height: 22.92)
        case .active:
            return mainCircleRect
        case .normal:
            return CGRect(x: 51 + 12.5 / 2,
                          y: 0 + 12.5 / 2,
                          width: 12.5,
                          height: 12.5)
        }
    }
    
    var addCircle2Rect: CGRect {
        switch kind {
        case .add:
            return CGRect(x: 86.17 + 45.83 / 2,
                          y: 5.5 + 45.83 / 2,
                          width: 45.83,
                          height: 45.83)
        case .active:
            return mainCircleRect
        case .normal:
            return CGRect(x: 69 + 25 / 2,
                          y: 3 + 25 / 2,
                          width: 25,
                          height: 25)
        }
    }
    
    var focusCircle1Rect: CGRect {
        switch kind {
        case .add:
            return mainCircleRect
        case .active:
            return CGRect(x: 0 + 35 / 2,
                          y: 114 + 35 / 2,
                          width: 35,
                          height: 35)
        case .normal:
            return mainCircleRect
        }
    }
    
    var focusCircle2Rect: CGRect {
        switch kind {
        case .add:
            return mainCircleRect
        case .active:
            return CGRect(x: 143 + 55 / 2,
                          y: 90 + 55 / 2,
                          width: 55,
                          height: 55)
        case .normal:
            return mainCircleRect
        }
    }
    
    var focusCircle3Rect: CGRect {
        switch kind {
        case .add:
            return mainCircleRect
        case .active:
            return CGRect(x: 65 + 70 / 2,
                          y: 145 + 70 / 2,
                          width: 70,
                          height: 70)
        case .normal:
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
        isValid ? DragGesture()
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
            .rotationEffect( kind == .active ? .degrees(45) : .zero)
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
        if isValid, kind == .active {
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
        if kind != .add {
            VStack {
                if kind == .normal {
                    Color.clear
                    Text(name)
                        .matchedGeometryEffect(id: "projectName", in: ns, anchor: .leading)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
                if kind == .active {
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
                focusCircle2
                focusCircle3
            button
            projectName
            labels
        }.frame(width: mainFrame.width, height: mainFrame.height)
            .onChange(of: name) { newValue in
                project?.name = name
                if let project = project {
                    try? PersistencyManager.shared.save(project: project)
                }
            }
    }
    
    func clickButton() {
        if kind == .add {
            project = CProject(name: "")
            try? PersistencyManager.shared.save(project: project!)
            kind = .active
            return
        }
        if kind == .active {
            if isValid {
                kind = .normal
            } else {
                if let project = project {
                    try? PersistencyManager.shared.delete(project: project)
                }
                project = nil
                kind = .add
            }
            return
        }
        if kind == .normal {
            kind = .active
        }
    }
    
    enum Kind {
        case add, normal, active
    }
}

struct ProjectButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProjectButtonComponent()
    }
}
