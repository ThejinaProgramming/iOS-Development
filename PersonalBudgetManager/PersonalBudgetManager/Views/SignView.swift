//
//  SignView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/27/25.
//

import SwiftUI

struct SignView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSignInActive = true
    @State private var isSuccessful = false

    @ObservedObject var reminderVM : ReminderViewModel
    var body: some View {
        NavigationStack{
            VStack{
                //App logo
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray.opacity(0.3))
                    .overlay(Text("Personal Wallet"))
                
                Text("Personal Budget Manager")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                //Sign In/ Sign Up toggle
                HStack{
                    Button("Sign In"){
                        isSignInActive = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isSignInActive ? Color.gray.opacity(0.3): Color.clear)
                    .foregroundColor(.black)
                    
                    Button("Sign Up"){
                        isSignInActive = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(!isSignInActive ? Color.gray.opacity(0.3) : Color.clear)
                    .foregroundColor(.black)
                }
                
                //Conditional fields
                VStack{
                    //Email
                    VStack(alignment: .leading){
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        TextField("your@email"+"."+"com", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    .padding(.top)
                    
                    //Password
                    VStack(alignment: .leading){
                        HStack{
                            Text("Password")
                                .font(.headline)
                                .foregroundColor(.gray)
                            if(isSignInActive){
                                Spacer()
                                NavigationLink(destination: ForgotPasswordView(reminderVM: reminderVM)){
                                    Text("Forgot Password?")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        SecureField("********", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        
                        //Confirm password
                        if(!isSignInActive){
                            VStack(alignment: .leading){
                                Text("Confirm Password")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                SecureField("********", text: $confirmPassword)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                            .padding(.top)
                        }
                        
                        //Main action button
                        Button(isSignInActive ? "Sign In" : "Create an Account"){
                            if isSignInActive{
                                //Add the logic
                                isSuccessful = true
                            }
                            else{
                                //Add the logic
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top)
                        
                        //OR continue with
                        HStack{
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.5))
                            Text("OR Continue With")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .lineLimit(1)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .padding(.top)
                        
                        //Social Sign In/Sign up buttons
                        HStack{
                            Button{
                                
                            }label: {
                                Text("Google")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .border(Color.black)
                                    .foregroundColor(.black)
                            }
                            
                            Button{
                                
                            }label: {
                                Text("Apple")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .border(Color.black)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top)
                        Spacer()
                    }
                    .padding(.top)
                }
                .fullScreenCover(isPresented: $isSuccessful){
                    ContentView(reminderVM: reminderVM)
                }
            }
            .padding()
        }
    }
}

