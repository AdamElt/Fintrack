//
//  ContentView.swift
//  Fintrack
//
//  Created by Adam El-Telbani on 3/29/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isSignedOut: Bool = false

    var body: some View {
        Group {
            if isSignedOut {
                LogInView()
            } else {
                ZStack {
                    LinearGradient(gradient: Gradient(colors : [.gray, .green]),
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    Spacer()
                    VStack {
                        
                        Button(action: {
                            signOut()
                        }) {
                            Text("Sign Out")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    func signOut() {
        do {
            try AuthService.shared.logout()
            isSignedOut = true
        } catch {
            print("Already logged out")
        }
    }
}

#Preview {
    ContentView()
}
