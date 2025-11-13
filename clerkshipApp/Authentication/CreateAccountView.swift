//  LoginView.swift
//  clerkshipApp

/*
 TODO: make text fields and error messages look better
 */

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var currentUser: CurrentUser
    @EnvironmentObject var qod: QODStore
    
    @State private var email = ""
    @State private var password = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var accountError: String? = nil
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // Firebase Download
    func createAccount() {
        Task {
            do {
                try await auth.createAccount(email: email, password: password)
                try await auth.createUser(fname: firstname, lname: lastname, email: email)
                await getNames()
                await getCurrUser()
                await getQOD()
                auth.isLoggedIn = true
            } catch {
                print("Error creating account")
            }
        }
    }
    
    func checkComplete() -> Bool{
        if email != "" && firstname != "" && lastname != ""{
            return true
        } else {
            return false
        }
    }
    
    func getNames() async{
        do {
            // Fetch users directly
            try await firebase.fetchUsers()
            if firebase.downloadSuccessful{
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
    
    var body: some View {
        if !auth.isLoggedIn {
            ZStack {
                // Color fills the entire screen
                backgroundColor.ignoresSafeArea()
                VStack {
                    Image("GreenUVMLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Create Account")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350, height: 100, alignment: .leading)
                }
            }
            VStack {
                TextField("First name...", text: $firstname)
                    .padding()
                    .cornerRadius(10)
                    .background(Color.gray.opacity(0.4))
                TextField("Last name...", text: $lastname)
                    .padding()
                    .cornerRadius(10)
                    .background(Color.gray.opacity(0.4))
                
                TextField("Email...", text: $email)
                    .padding()
                    .cornerRadius(10)
                    .background(Color.gray.opacity(0.4))
                    .textInputAutocapitalization(.never)
                // TODO: remove password
                SecureField("Password...", text: $password)
                    .padding()
                    .cornerRadius(10)
                    .background(Color.gray.opacity(0.4))
                    .textInputAutocapitalization(.never)
                
                if auth.errorMessage != nil{
                    switch auth.errorMessage {
                    case "The email address is badly formatted.":
                        Text("Please enter a valid email address")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    case "The password must be 6 characters long or more.":
                        Text("Password must be at least 6 characters long")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    default:
                        Text("Error creating your account. Please try again later.")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                
                BigButtonView(
                    text: "Create Account",
                    action: createAccount,
                    foregroundColor: .white,
                    backgroundColor: backgroundColor,
                    disabled: !checkComplete()
                )
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
    // TODO: it's fine if we want these now, but should take out later
    CreateAccountView()
        .environmentObject(FirebaseService())
        .environmentObject(AuthService())
        .environmentObject(UserStore())
        .environmentObject(CurrentUser())
        .environmentObject(QODStore())
}
