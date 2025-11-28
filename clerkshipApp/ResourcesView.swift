// ResourcesView.swift
// clerkshipApp

import SwiftUI

struct ResourceSection: Identifiable {
    let id = UUID()
    let title: String
    let resources: [ResourceItem]
}

struct ResourceItem: Identifiable {
    let id = UUID()
    let title: String
    let destination: Destination?
}

// View
struct ResourcesView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router
    
    // Track which section is open
    @State private var openSection: UUID? = nil
    
    // Data
    private let resourceSections: [ResourceSection] = [
        ResourceSection(title: "Exams", resources: [
            ResourceItem(title: "Breast Exam", destination: .breastExam),
            ResourceItem(title: "Pelvic Exam & Pap Smear", destination: nil)
        ]),
        ResourceSection(title: "Patient Care", resources: [
            ResourceItem(title: "New Patient History", destination: nil),
            ResourceItem(title: "Prenatal-Antepartum Patient", destination: nil),
            ResourceItem(title: "Vaginal Delivery", destination: nil)
        ]),
        ResourceSection(title: "Labor & Triage", resources: [
            ResourceItem(title: "Labor Triage", destination: .laborTriage),
            ResourceItem(title: "Preeclampsia Triage", destination: nil),
            ResourceItem(title: "Laboring Patient", destination: nil)
        ]),
        ResourceSection(title: "Surgery & Postop", resources: [
            ResourceItem(title: "C-Section", destination: nil),
            ResourceItem(title: "Postpartum Patient/SOAP Note", destination: nil),
            ResourceItem(title: "Operating Room Functionality", destination: nil),
            ResourceItem(title: "Closing Skin Incision - Subcuticular Stitch", destination: nil),
            ResourceItem(title: "Postoperative Check", destination: nil),
            ResourceItem(title: "Postop Visit - Morning Rounds", destination: nil)
        ])
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                Text("Resources")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                // Scrollable sections
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(resourceSections) { section in
                            sectionView(section: section)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                }
                
                // Bottom navigation
                NavTab(currView: .resources)
            }
        }
    }
    
    // Section View
    @ViewBuilder
    private func sectionView(section: ResourceSection) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with chevron
            HStack {
                Text(section.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
                    .rotationEffect(.degrees(openSection == section.id ? 90 : 0))
                    .animation(.easeInOut, value: openSection == section.id)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onTapGesture {
                withAnimation(.spring()) {
                    openSection = (openSection == section.id ? nil : section.id)
                }
            }
            
            // Expanded content
            if openSection == section.id {
                VStack(spacing: 12) {
                    ForEach(section.resources) { item in
                        MainButtonView(title: item.title, color: buttonColor) {
                            if let destination = item.destination {
                                router.push(destination)
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 5)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

// Preview
#Preview {
    NavigationStack {
        ResourcesView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
}

