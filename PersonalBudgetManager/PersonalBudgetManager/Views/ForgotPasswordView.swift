//
//  ForgotPasswordView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/27/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @StateObject private var signVM = SignViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Forgot Password?")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                
                Text("Enter your email address and we'll send you a code to reset your password.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Text("Email")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                TextField("your@email"+"."+"com", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom)
                
                Button("Send Reset Code"){
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.bottom)
                
                HStack{
                    Spacer()
                    NavigationLink(destination: SignView(signViewModel: signVM)){
                        Text("Back to Sign in")
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

