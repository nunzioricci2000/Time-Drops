//
//  Onboarding.swift
//  Chimpions
//
//  Created by Bruno De Vivo on 22/02/23.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        ZStack{
            StreamComponent()
            
            VStack{
                
                VStack (alignment: .leading){
                    Text("Welcome!")
                        .font(.system(size: 50.0))
                        .fontWeight(.semibold)
                    
                    
                    Text("appName? will help you manage your daily tasks.")
                        .font(.system(size: 25.0))
                        .fontWeight(.medium)
                    
                }
                .padding(.top, 130.0)
                
                Spacer()
                
                VStack {
                    Text("To do that, let’s set your daily working hours.")
                        .font(.system(size: 20))
                    
                    HStack{
                        Spacer()
                        ForEach(1...7, id: \.self){ id in
                            VStack {
                                ZStack{
                                    Rectangle()
                                        .cornerRadius(6.0)
                                        .frame(width: 35, height: 35)
                                        .padding(.horizontal, 5.0)
                                        .foregroundColor(Color("PlaceHolderFirst"))
                                    Text("\(Int.random(in: 0...24))")
                                }
                                Text("D\(id)")
                                    .foregroundColor(Color("PlaceHolderSecond"))
                            }
                        }
                        Spacer()
                    }
                    
                }
                .offset(y: -90)
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .cornerRadius(15.0)
                        .frame(width: 120, height: 60)
                    Text("Done")
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                }
                
            }
            .padding(.horizontal)
        }
        
    }
    
    
    
    struct Onboarding_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding()
        }
    }
}
