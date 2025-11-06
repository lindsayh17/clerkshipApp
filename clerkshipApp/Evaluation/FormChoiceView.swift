//
//  FormChoiceView.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/6/25.
//

import SwiftUI

struct FormChoiceView: View{
    var body: some View{
        MainButtonView(title: "OB (L&D) Service", color: Color("ButtonColor"))
        MainButtonView(title: "Clinic Service", color: Color("ButtonColor"))
        MainButtonView(title: "Inpatient Gyn Service", color: Color("ButtonColor"))
    }
}

#Preview {
    FormChoiceView()
}
