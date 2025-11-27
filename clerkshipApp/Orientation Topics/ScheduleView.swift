//  ScheduleView.swift
//  clerkshipApp

import SwiftUI

struct ScheduleData: Identifiable {
    let id = UUID()
    let title: String
    let descriptions: [String]
}

struct ScheduleView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    // State for navigation
    @State private var currentView: Destination = .resources
    @EnvironmentObject var currUser: CurrentUser
    @Environment(\.dismiss) var dismiss
    
    // Track which day is expanded
    @State private var openDay: UUID? = nil
    
    // Schedule data
    private let schedule: [ScheduleData] = [
        ScheduleData(title: "Monday, 10/13",
                      descriptions: [
                        "**All students**",
                        "*Simulation Center - Rowell 2nd Floor*",
                        "7:00am - 8:00am: Introduction & Pre-Rotation Knowledge Test (bring a computer)\n8:00am - 12:00pm: Simulation Activities & Hospital Tour",
                        "**All students**",
                        "*Meded 302/303*",
                        "Hot lunch will be served - please email Sara Tourville with any food/allergy considerations.",
                        "12:00pm: Lunch & Clerkship Information\n12:30pm - 1:30pm: Intrapartum FHR Interpretation Teaching Session\n1:30pm - 1:45pm: Break\n1:45pm - 2:30pm: Labor Support and Trauma Informed Care Session\n2:30pm - 3:30pm: Family Planning on the OBGyn Clerkship",
                        "**L. Amaio, J. Bates, A. Gorbacheva, J. Reigle, B. Sebuufu**",
                        "*Given Assessment Center*",
                        "5:45pm - 8:45pm: Pelvic & Breast Refresher"
                      ]),
        ScheduleData(title: "Tuesday 10/14",
                      descriptions: [
                        "**K. Blau, B. Canova, J. Hurley, R. Marawala**",
                        "*Given Assessment Center*",
                        "5:45pm - 8:15pm: Pelvic & Breast Refresher"
                      ]),
        ScheduleData(title: "Wednesday 10/15",
                      descriptions: [
                        "**C. Bauman, J. Du, M. Lapointe-Gagner, S. Tukel**",
                        "*Given Assessment Center*",
                        "5:45pm - 8:15pm: Pelvic & Breast Refresher"
                      ])
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Schedule")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                        .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 20) {
                        ForEach(schedule) { day in
                            daySection(day: day)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Day Dropdown View
    @ViewBuilder
    private func daySection(day: ScheduleData) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with title + chevron
            HStack {
                Text(day.title)
                    .font(.title3)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
                    .rotationEffect(.degrees(openDay == day.id ? 90 : 0))
                    .animation(.easeInOut, value: openDay == day.id)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onTapGesture {
                withAnimation(.spring()) {
                    openDay = (openDay == day.id ? nil : day.id)
                }
            }
            
            // Expanded content
            if openDay == day.id {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(day.descriptions, id: \.self) { desc in
                        Text(LocalizedStringKey(desc))
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 5)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScheduleView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
}
