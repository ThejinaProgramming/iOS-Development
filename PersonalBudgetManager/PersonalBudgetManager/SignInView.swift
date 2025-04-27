//
//  SignInView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/27/25.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            //App logo
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 100, height: 100)
                .overlay(
                    Text("Personal Wallet")
                        .foregroundColor(.black)
                )
                .padding(.bottom)
            
            Text("Personal Budget Manager")
                .font(.title)
                .padding(.bottom)
                .bold()
            
            Text("Sign In")
                .font(.headline)
                .padding(.bottom)
            
            //Email
            Text("Email")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            TextField("your@email.com", text:$email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom)
            
            //Password
            Text("password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            SecureField("********", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom)
            
            //Forgot password
            HStack{
                Spacer()
                Button("Forgot password?"){
                    
                }
                .foregroundColor(.blue)
            }
            .padding(.bottom)
            
            //Sign in button
            Button("Sign In"){
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom)
            
            Text("OR Continue with")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            //Social login buttons
            HStack{
                Button("Google"){
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                Button("Apple"){
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            
            Spacer()
            
            //Sign up
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                Button("Sign Up"){
                    
                }
                .foregroundColor(.blue)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
