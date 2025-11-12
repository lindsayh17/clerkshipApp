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
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var formStore: FormStore
    
    @State private var selection: FormChoice = .clinic
    
    var body: some View{
        MainButtonView(title: "OB (L&D) Service", color: Color("ButtonColor"), action: {selection = .obstetrics})
        MainButtonView(title: "Clinic Service", color: Color("ButtonColor"), action: {selection = .clinic})
        MainButtonView(title: "Inpatient Gyn Service", color: Color("ButtonColor"), action: {selection = .inpatient})
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
