//  FormChoiceView.swift
//  clerkshipApp

import SwiftUI

enum QuestionResponse {
    case novice
    case apprentice
    case expert
    case none
}

struct FormChoiceView: View{
    var body: some View{
        MainButtonView(title: "OB (L&D) Service", color: Color("ButtonColor"))
        MainButtonView(title: "Clinic Service", color: Color("ButtonColor"))
        MainButtonView(title: "Inpatient Gyn Service", color: Color("ButtonColor"))
    }
}


struct RubricView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    let currStudent: User
    
    var body: some View {
        
    }
}

#Preview {
    FormChoiceView()
}
