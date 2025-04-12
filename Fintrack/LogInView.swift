//
//  LandingView.swift
//  Fintrack
//
//  Created by Adam El-Telbani on 4/9/25.
//
import SwiftUI

struct LogInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var resetMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.green.opacity(0.8), .black]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    // App Title
                    Text("Fintrack")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)

                    // Email & Password Fields
                    VStack(spacing: 16) {
                        IconTextField(placeholder: "Email", text: $email)
                        SecureInputView("Password", text: $password)
                        Button(action: {
                            handleLogin()
                        }) {
                            Text("Log In")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            forgotPassword()
                        }) {
                            Text("Forgot Password?")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }

                    // Divider
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

                    // Social Icon Buttons
                    HStack(spacing: 24) {
                        SocialIconButton(imageName: "Google")
                        SocialIconButton(imageName: "GitHub")
                        SocialIconButton(systemIcon: "apple.logo")
                    }
                    .padding(.top, 10)

                    // Sign Up Link
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 30)
            }
        }
    }
    
    func handleLogin() {
        AuthService.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let authResult):
                print("✅ Logged in as: \(authResult.user.email ?? "unknown")")
                isLoggedIn = true
                
            case .failure(let error):
                print("❌ Login failed: \(error.localizedDescription)")
            }
        }
    }
    
    func forgotPassword() {
        AuthService.shared.passwordReset(email: email) { result in
            switch result {
            case .success:
                resetMessage = "✅ Password reset email sent."
                
            case.failure(let error):
                print ("❌ Password reset failed: \(error.localizedDescription)")
            }
        }
    }
    
    }

#Preview {
    LogInView()
}

// MARK: - Custom Styled TextField with Icon
struct IconTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .foregroundColor(.white)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
    }
}

// MARK: - Social Icon Button
struct SocialIconButton: View {
    var imageName: String? = nil
    var systemIcon: String? = nil

    var body: some View {
        Button(action: {
            // Placeholder for social login action
        }) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 50, height: 50)

                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                } else if let systemIcon = systemIcon {
                    Image(systemName: systemIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 22, height: 22)
                }
            }
        }
    }
}
