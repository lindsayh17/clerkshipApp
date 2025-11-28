///  Destination.swift
//  clerkshipApp

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
    case settings
    
    // orientation
    case orientation
    case schedule
    case familyPlan
    case trauma
    case surgicalInst
    case locations
    case cvmc     // CVMC
    case pmc      // Porter Medical Center
    case rrmc
    
    // put all requirement views beneath here
    case requirements
    case attendance
    case obstetricService
    case clinicService
    case inpatientGynService
    case apgo
    case clinicalReasoning
    case rce
    case midRotation
    case summativeClerkship
    case shelfExam
    
    // resources
    case resources
    case breastExam
    case laborTriage

    // form views
    case search
    case users
    case evalChoice(userToEval: User)
    case eval(formState: EvalFormState, student: User)
    case seeEval
        
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
        case .settings:
            return EmptyView()
            
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
        case .locations:
            return LocationsView()
        case .cvmc:
            return CVMCView()
        case .pmc:
            return PMCView()
        case .rrmc:
            return RRMCView()
            
            
        case .requirements:
            return ClerkshipRequirementsView()
        case .attendance:
            return AttendanceView()
        case .apgo:
            return APGOView()
        case .clinicalReasoning:
            return ClinicalReasoningView()
        case .clinicService:
            return ClinicServiceView()
        case .inpatientGynService:
            return InpatientGynServiceView()
        case .midRotation:
            return MidRotationView()
        case .obstetricService:
            return ObstetricServiceView()
        case .rce:
            return RCEView()
        case .summativeClerkship:
            return SummativeClerkshipView()
        case .shelfExam:
            return ShelfExamView()

            
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
        case .seeEval:
            return EvalSummaryView()
        
        }
    }
}
