//
//  Onboarding.swift
//  Chimpions
//
//  Created by Bruno De Vivo on 22/02/23.
//

import SwiftUI

struct Onboarding: View {
    @State var selection: Int = 1
    @State var onFinish: () -> () = { }
    
    var body: some View {
        TabView(selection: $selection) {
            Image("onboarding/1")
                .resizable()
                .scaledToFill()
                .tag(1)
                .onTapGesture {
                    selection += 1
                }
            Image("onboarding/2")
                .resizable()
                .scaledToFill()
                .tag(2)
                .onTapGesture {
                    selection += 1
                }
            Image("onboarding/3")
                .resizable()
                .scaledToFill()
                .tag(3)
                .onTapGesture {
                    selection += 1
                }
            Image("onboarding/4")
                .resizable()
                .scaledToFill()
                .tag(4)
                .onTapGesture {
                    onFinish()
                }
        }.ignoresSafeArea()
            .padding(-10)
    }
    
    
    
    struct Onboarding_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding()
        }
    }
}
