//
//  RootView.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 10/30/25.
//

import SwiftUI

struct RootView: View {
    private let backgroundColor = Color("BackgroundColor")
    @State var loginFlag = false
    @State var newAccountFlag = false
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                // TODO: put logo here
                
                Text("UVM OBGYN Clerkship")
                    .padding()
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                // log in button
                BigButtonView(
                    text: "Log In",
                    action: {loginFlag = true},
                    foregroundColor: .white,
                    backgroundColor: backgroundColor
                ).padding()
                
                // create account button
                BigButtonView(
                    text: "Create Account",
                    action: {newAccountFlag = true},
                    foregroundColor: backgroundColor,
                    backgroundColor: .white
                ).padding()
                
            }
        }
        
    }
}

#Preview {
    RootView()
}
