//
//  Destination.swift
//  clerkshipApp
//

import SwiftUI

enum Destination: Identifiable {
    var id: String { "\(self)" }

    // auth screens
    case root
    case login
    case register
    
    // user aid
    case home
    case profile
    case quickFacts
    
    // orientation
    case orientation
    case schedule
    case familyPlan
    case trauma
    case surgicalInst
    
    // put all requirement views beneath here
    case requirements
    
    // resources
    case resources
    case breastExam
    case laborTriage

    // form views
    case search
    case users
    case evalChoice(userToEval: User)
    case eval(formState: EvalFormState, student: User)
        
}

extension Destination: Hashable {
    // overloaded operator
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Destination {
    var screen: AnyView { AnyView(destinationView) }

    private var destinationView: any View {
        switch self {
        // auth views
        case .root:
            return RootView()
        case .login:
            return LoginView()
        case .register:
            return CreateAccountView()
            
            
        case .home:
            return HomeView()
        case .profile:
            return ProfileView()
        case .quickFacts:
            return QuickFactsView()
            
        case .orientation:
            return OrientationView()
        case .schedule:
            return ScheduleView()
        case .familyPlan:
            return FamilyPlanningSessionView()
        case .trauma:
            return TraumaView()
        case .surgicalInst:
            return SurgicalInstrumentsView()
            
            
        case .requirements:
            return ClerkshipRequirementsView()
            
        // resources
        case .resources:
            return ResourcesView()
        case .breastExam:
            return BreastExamView()
        case .laborTriage:
            return LaborTriageView()
            
            
        case .search:
            return SearchView()
        // TODO: this could take you to the profile of each user
        case .users:
            return SearchView()
        case .evalChoice(let student):
            return FormChoiceView(currStudent: student)

        case .eval(let form, let student):
            return EvaluationView(formState: form, currStudent: student)
        
//        case .empty:
//            return EmptyView()
        }
    }
}
