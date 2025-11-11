//  FormChoiceView.swift
//  clerkshipApp

import SwiftUI

enum FormType {
    case OBLD
    case clinic
    case impatientGyn
}

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
    
    // I don't know if this is actually the correct label for this but
    let clinicServiceForm = [
        "History Gathering": [
            "Amount of information gathered",
            "Linking information in a clinically relevant fashion",
            "Patient-focused communication",
            "Tailoring history to clinical encounter"
        ],
        "Physical Exam": [
            "Correctly performing physical exam",
            "Identifying abnormal exam findings",
            "Tailoring exam to clinical encounter",
        ],
        "Differential diagnosis": [
            "Length of Ddx list",
            "Prioritizing and narrowing Ddx",
            "Ability to outline workup to confirm/exclude ddx"
        ],
        "Interpreting diagnostic/screening tests": [
            "Gathering results and updating team",
            "Understands rationale for testing",
            "Interpreting results",
            "Identifying key tests for common conditions",
        ],
        "Retrieving Evidence": [
            "Identifying evidence pertinent to clinical care",
            "Formulating complex questions based on evidence to advance patient’s care",
        ],
        "Clinical documentation": [
            "Accurately capturing the patient story",
            "Errors within documentation",
            "Including relevant problems and documenting clinical decision making",
        ],
        "Oral presentations": [
            "Accuracy and logical sequence of presentation",
            "Inclusion of pertinent positives and negatives",
            "Number of clarifying questions required",
            "Ability to spontaneously present H&P without notes",
        ],
        "Team integration": [
            "Active integration into the team",
            "Developing plans with input from patient/family members",
            "Recognition of role and seeking help when appropriate",
        ]
    ]
    
    
    
    var body: some View {
        
    }
}


#Preview {
    FormChoiceView()
}
