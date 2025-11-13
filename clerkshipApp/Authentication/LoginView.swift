import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var currentUser: CurrentUser
    @EnvironmentObject var qod: QODStore
    
    @State private var email = ""
    @State private var password = ""
    @State private var loading = false
    @State private var loginError: String? = nil
    
    private let backgroundColor = Color("BackgroundColor")
    
    func getNames() async{
        do {
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
    
    func signin() {
        Task {
            do {
                try await auth.signIn(email: email, password: password)
                await getNames()
                await getCurrUser()
                await getQOD()
                auth.isLoggedIn = true
            }catch {
                loginError = "Wrong email or password"
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) { // top-level ZStack to overlay back button
                VStack {
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

                    VStack {
                        TextField("Email...", text: $email)
                            .padding()
                            .cornerRadius(10)
                            .background(Color.gray.opacity(0.4))
                            .textInputAutocapitalization(.never)
                            .foregroundColor(.black)
                            .onChange(of: email) { loginError = nil }

                        SecureField("Password...", text: $password)
                            .padding()
                            .cornerRadius(10)
                            .background(Color.gray.opacity(0.4))
                            .textInputAutocapitalization(.never)
                            .foregroundColor(.black)
                            .onChange(of: password) { loginError = nil }

                        if let error = loginError {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }

                        BigButtonView(
                            text: "Log In",
                            action: signin,
                            foregroundColor: .white,
                            backgroundColor: backgroundColor
                        )
                        .padding()
                    }
                    .padding()
                }

                // Overlay the floating back button
                BackButton()
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .ignoresSafeArea(.all, edges: .top)
            }
            .navigationDestination(isPresented: $auth.isLoggedIn) { HomeView() }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    LoginView()
        .environmentObject(FirebaseService())
        .environmentObject(UserStore())
        .environmentObject(CurrentUser())
        .environmentObject(AuthService())
        .environmentObject(QODStore())
}

