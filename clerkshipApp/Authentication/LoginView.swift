//  LoginView.swift
//  clerkshipApp

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    // Navigation tool
    @EnvironmentObject private var router: Router
    
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var currentUser: CurrentUser
    @EnvironmentObject var qod: QODStore
    
    @State private var email = ""
    @State private var password = ""
    @State private var loginError: String? = nil
    
    private let backgroundColor = Color("BackgroundColor")
    
    // MARK: - Firebase fetch functions
    func getNames() async {
        do {
            try await firebase.fetchUsers()
            if firebase.downloadSuccessful {
                userStore.allUsers.removeAll()
                for user in firebase.users {
                    userStore.addUser(user)
                }
            }
        } catch {
            print("Error fetching users: \(error)")
        }
    }
    
    func getCurrUser() async {
        do {
            try await firebase.fetchUser(currEmail: auth.currentUser)
            if firebase.downloadSuccessful {
                currentUser.user = firebase.currUser
            }
        } catch {
            print("Error fetching users: \(error)")
        }
    }
    
    func getQOD() async {
        do {
            try await firebase.fetchRandomQuestion()
            if firebase.downloadSuccessful {
                qod.qod = firebase.question
            }
        } catch {
            print("Error fetching questions: \(error)")
        }
    }
    
    func signin() {
        Task {
            do {
                try await auth.signIn(email: email, password: password)
                await getNames()
                await getCurrUser()
                await getQOD()
                auth.isLoggedIn = true
                
                // switch the root from the welcome screen to home
                router.switchRoot(.home)
            } catch {
                loginError = "Wrong email or password"
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 20) {
                ZStack {
                    backgroundColor.ignoresSafeArea()
                    VStack {
                        Image("GreenUVMLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Welcome Back")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 350, height: 100, alignment: .leading)
                    }
                }
                
                VStack(spacing: 15) {
                    // Email
                    TextField("Email...", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(.black)
                        .onChange(of: email) { _ in loginError = nil }
                    
                    // Password
                    SecureField("Password...", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(.black)
                        .onChange(of: password) { _ in loginError = nil }
                    
                    // Error message
                    if let error = loginError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // Login Button
                    BigButtonView(
                        text: "Log In",
                        action: signin,
                        foregroundColor: .white,
                        backgroundColor: backgroundColor
                    )
                    .padding(.top, 10)
                }
                .padding(.horizontal, 30)
            }
            
            // Floating back button
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        // Navigate to HomeView on login
//        .navigationDestination(isPresented: $auth.isLoggedIn) {
//            HomeView()
//        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        LoginView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(UserStore())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
    .environmentObject(QODStore())
}
