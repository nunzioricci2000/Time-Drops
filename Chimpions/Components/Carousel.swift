//
//  Carousel.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 03/03/23.
//

import SwiftUI

struct Carousel: View {
    @State var selected: Int = 0
    @State var startLocation: CGPoint?
    @State var dragOffset: CGFloat = 0
    @State var rect: CGRect = .zero
    let content: [AnyView]
    @State private var tail: AnyView?
    
    var elementNumbers: Int {
        content.count + (tail != nil ? 1 : 0)
    }
    
    var selectedOffset: CGFloat {
        rect.width / 4 * CGFloat(-selected * 2 - 1)
    }
    var offset: CGFloat {
        selectedOffset + dragOffset
    }
    
    init<Views>(@ViewBuilder content: @escaping () -> TupleView<Views>) {
        self.content = content().getViews
    }
    
    init<Element>(_ list: [Element], content: (Element) -> some View) {
        self.content = list.map({ AnyView(content($0)) })
    }
    
    private init(_ content: [AnyView], tail: AnyView?) {
        self.content = content
        self.tail = tail
    }
    
    func addTail(@ViewBuilder tail: @escaping () -> some View) -> Carousel {
        return Carousel(content, tail: AnyView(tail()))
    }
    
    var body: some View {
        GeometryReader { rect in
            HStack(spacing: 0) {
                Color.clear.frame(width: rect.size.width / 2)
                ForEach(content.indices, id: \.self) { index in
                    content[index]
                        .frame(width: rect.size.width / 2)
                }
                if tail != nil {
                    tail!
                        .frame(width: rect.size.width / 2)
                }
                Color.clear.frame(width: rect.size.width / 2)
            }.background(Color.black.opacity(0.001)).offset(x: offset)
                .gesture(DragGesture()
                    .onChanged { gesture in
                        if startLocation == nil {
                            startLocation = gesture.location
                        }
                        dragOffset = (gesture.location - startLocation!).dx
                    }.onEnded { gesture in
                        startLocation = nil
                        if dragOffset < -(rect.size.width) / 4 {
                            selected += 1
                            if selected >= elementNumbers {
                                selected = elementNumbers - 1
                            }
                        }
                        if dragOffset > (rect.size.width) / 4 {
                            selected -= 1
                            if selected < 0 {
                                selected = 0
                            }
                        }
                        dragOffset = 0
                    })
                .onChange(of: rect) { newValue in
                    self.rect = rect.frame(in: .global)
                }.onAppear {
                    self.rect = rect.frame(in: .global)
                }
                .animation(.interactiveSpring(), value: offset)
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel([Color.red, .green, .blue]) { element in
            element
        }.addTail {
            Color.brown
        }
    }
}

extension GeometryProxy: Equatable {
    public static func == (lhs: GeometryProxy, rhs: GeometryProxy) -> Bool {
        lhs.size == rhs.size
    }
}

extension TupleView {
    var getViews: [AnyView] {
        makeArray(from: value)
    }
    
    private struct GenericView {
        let body: Any
        
        var anyView: AnyView? {
            AnyView(_fromValue: body)
        }
    }
    
    private func makeArray<Tuple>(from tuple: Tuple) -> [AnyView] {
        func convert(child: Mirror.Child) -> AnyView? {
            withUnsafeBytes(of: child.value) { ptr -> AnyView? in
                let binded = ptr.bindMemory(to: GenericView.self)
                return binded.first?.anyView
            }
        }
        
        let tupleMirror = Mirror(reflecting: tuple)
        return tupleMirror.children.compactMap(convert)
    }
}
