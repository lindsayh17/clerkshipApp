//  AdminDashboardView.swift
//  clerkshipApp

import SwiftUI

struct AdminDashboardView: View {
    // Admin webpage
    private let adminURL = URL(string: "https://macorcor.w3.uvm.edu/")!

    var body: some View {
        WebView(url: adminURL)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Admin Dashboard")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AdminDashboardView()
}
