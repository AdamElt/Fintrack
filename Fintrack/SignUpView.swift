//
//  Signup.swift
//  Fintrack
//
//  Created by Adam El-Telbani on 4/9/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var isSignedIn: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        Group {
            if isSignedIn {
                ContentView()
            } else {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.green.opacity(0.8), .black]),startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 16){
                        Text("Get Started")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                        TextField("Enter your email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                        
                        SecureInputView("Enter your password", text: $password)

                        Button(action: {
                            handleSignUp()
                        }) {
                            Text("Create Account")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(.top, 4)
                        }
                        
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.3))
                            Text("or")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.caption)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.3))
                        }
                        .padding(.top, 10)
                        
                        NavigationLink(destination: LogInView()) {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
    }
    
    func handleSignUp(){
        print("🧪 handleSignUp called")
        AuthService.shared.register(email: email, password: password) { result in
            switch result {
            case .success(let authResult):
                print("✅ Logged in as: \(authResult.user.email ?? "unknown")")
                isSignedIn = true
                
            case .failure(let error):
                print("❌ Login failed: \(error.localizedDescription)")
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    SignUpView()
}
