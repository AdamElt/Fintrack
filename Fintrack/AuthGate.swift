//
//  AuthGate.swift
//  Fintrack
//
//  Created by Adam El-Telbani on 4/12/25.
//

import SwiftUI
import FirebaseAuth

struct AuthGate: View {
    var body: some View {
        Group{
            if Auth.auth().currentUser != nil {
                ContentView()
            }
            else {
                SignUpView()
            }
        }
    }
}
