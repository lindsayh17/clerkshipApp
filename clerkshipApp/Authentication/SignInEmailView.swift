//
//  SignInEmailView.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/27/25.
//
import SwiftUI

final class SignInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
}

struct SignInEmailView: View{
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View{
        VStack{
            TextField("Email...", text: $viewModel.email)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
        }
        .padding()
    }
}

#Preview {
    SignInEmailView()
}
