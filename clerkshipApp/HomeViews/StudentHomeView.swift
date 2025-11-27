//
//  StudentHomeView.swift
//  clerkshipApp
//

import SwiftUI

struct StudentHomeView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    @State private var currentView = Destination.home
    
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var auth: AuthService

    
    // Router object to centralize navigation
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        // show normal app content
        ZStack {
            // Fill the screen with background color
            backgroundColor.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 4){
                Text("Welcome, \(currUser.user?.firstName ?? "Student")")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                
                ScrollView {
                    Button {
                        router.push(.seeEval)
                    } label: {
                        EvaluationSummaryMiniView()
                            .padding(.horizontal)
                    }
                    
                    // Daily Question
                    QODView()
                        .padding()
                    
                    VStack(spacing: 20) {
                        
                        HomeNavCard(title: "Quick Facts", icon: "book.fill", color: .purple) {
                            router.push(.quickFacts)
                        }
                        
                        HomeNavCard(title: "Orientation", icon: "figure.wave", color: .teal) {
                            router.push(.orientation)
                        }
                        
                        HomeNavCard(title: "Clerkship Requirements", icon: "checkmark.seal.fill", color: .pink) {
                            router.push(.requirements)
                        }
                        
                        HomeNavCard(title: "Evaluation Form", icon: "doc.text.fill", color: .orange) {
                            if let student = currUser.user {
                                router.switchRoot(.evalChoice(userToEval: student))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                    
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    StudentHomeView()
        .environmentObject(FirebaseService())
        .environmentObject(CurrentUser())
        .environmentObject(AuthService())
        .environmentObject(Router(root: .home))
        .environmentObject(QODStore())
}
