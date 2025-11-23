import SwiftUI

struct CreateAccountView: View {
    // Navigation tool
    @EnvironmentObject private var router: Router
    
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
                
                // switch the root from the welcome screen to home
                router.switchRoot(.home)
            } catch {
                print("Error creating account")
            }
        }
    }
    
    func checkComplete() -> Bool{
        !email.isEmpty && !firstname.isEmpty && !lastname.isEmpty
    }
    
    func getNames() async {
        do {
            try await firebase.fetchUsers()
            if firebase.downloadSuccessful{
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
            print("Error fetching current user: \(error)")
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
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                ZStack {
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
                    
                    SecureField("Password...", text: $password)
                        .padding()
                        .cornerRadius(10)
                        .background(Color.gray.opacity(0.4))
                        .textInputAutocapitalization(.never)
                    
                    if let errorMessage = auth.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
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
            }
            
            // Floating back button
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
//        .navigationDestination(isPresented: $auth.isLoggedIn) { HomeView() }
    .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack{
        CreateAccountView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(AuthService())
    .environmentObject(UserStore())
    .environmentObject(CurrentUser())
    .environmentObject(QODStore())
}

