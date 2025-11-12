//  LoginView.swift
//  clerkshipApp
//
// username: lhall11@uvm.edu
// password: 123456

/*
 TODO: make errors look better
 */

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var currentUser: CurrentUser
    @EnvironmentObject var qod: QODStore
    @State private var email = ""
    @State private var password = ""
    @State private var loading = false
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    func getNames() async{
        do {
            // Fetch users directly
            try await firebase.fetchUsers()
            if firebase.downloadSuccessful{
                userStore.allUsers.removeAll()
                for user in firebase.users{
                    userStore.addUser(user)
                }
            }
        } catch {
            print("Error fetching users: \(error)")
        }
    }
    
    func getCurrUser() async{
        do {
            // Fetch users directly
            try await firebase.fetchUser(currEmail: auth.currentUser)
            if firebase.downloadSuccessful{
                currentUser.user = firebase.currUser
            }
        } catch {
            print("Error fetching users: \(error)")
        }
    }
    
    func getQOD() async{
        do{
            try await firebase.fetchRandomQuestion()
            if firebase.downloadSuccessful{
                qod.qod = firebase.question
            }
        } catch {
            print("Error fetching questions: \(error)")
        }
    }
    
    // Firebase Download
    func signin() {
        Task {
            do {
                try await auth.signIn(email: email, password: password)
                await getNames()
                await getCurrUser()
                await getQOD()
                auth.isLoggedIn = true
            }catch {
                print("Login error: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        if !auth.isLoggedIn {
            ZStack {
                // Color fills the entire screen
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
            VStack {
                TextField("Email...", text: $email)
                    .padding()
                    .cornerRadius(10)
                    .background(Color.gray.opacity(0.4))
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                
                SecureField("Password...", text: $password)
                    .padding()
                    .cornerRadius(10)
                    .background(Color.gray.opacity(0.4))
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                
                BigButtonView(
                    text: "Log In",
                    action: signin,
                    foregroundColor: .white,
                    backgroundColor: backgroundColor
                ).padding()
                
            }
            .padding()
        } else {
            HomeView()
        }
        BackButton()
        
    }
}


// Preview
#Preview {
    LoginView().environmentObject(FirebaseService())
        .environmentObject(UserStore())
        .environmentObject(CurrentUser())
        .environmentObject(AuthService())
        .environmentObject(QODStore())
}
