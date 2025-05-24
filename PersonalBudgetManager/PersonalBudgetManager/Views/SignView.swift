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
    
    @ObservedObject var signViewModel: SignViewModel
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    func checkLogin(){
        isSuccessful.toggle()
    }
    
    func checkPassword(password: String, confirmPassword: String){
        if(password != confirmPassword){
            alertMessage = "Passwords are mismatch!"
            showAlert.toggle()
        }
    }
    
    func checkFieldsSignup(email: String, password: String, confirmPassword: String){
        if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
            alertMessage = "All fields are required"
            showAlert = true
        }
    }
    
    func checkFieldsSignin(email: String, password: String){
        if (email.isEmpty || password.isEmpty){
            alertMessage = "All fields are required"
            showAlert = true
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                //App logo
                Image("LOGO1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .padding(.top, 40)
                
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
                    .background(isSignInActive ? Color.blue : Color.clear)
                    .foregroundColor(isSignInActive ? .white : .blue)
                    .cornerRadius(8)
                    
                    Button("Sign Up"){
                        isSignInActive = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(!isSignInActive ? Color.blue : Color.clear)
                    .foregroundColor(!isSignInActive ? .white : .blue)
                    .cornerRadius(8)
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
                                NavigationLink(destination: ForgotPasswordView()){
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
                            checkFieldsSignin(email: email, password: password)
                            if (isSignInActive && !showAlert){
                                for user in signViewModel.users{
                                    if((user.email == email) && (user.password == password)){
                                        isSuccessful = true
                                    }
                                }
                                if (!isSuccessful){
                                        alertMessage = "Credentials are incorrect."
                                        showAlert = true
                                }
                            }
                            else{
                                checkPassword(password: password, confirmPassword: confirmPassword)
                                checkFieldsSignup(email: email, password: password, confirmPassword: confirmPassword)
                                if(!showAlert){
                                    signViewModel.addUser(email: email, password: password)
                                }
                                email = ""
                                password = ""
                                confirmPassword = ""
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
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
                                    .background(Color.white)
                                    .foregroundColor(.blue)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.blue, lineWidth: 1)
                                    )
                                    .cornerRadius(8)
                            }
                            
                            Button{
                                
                            }label: {
                                Text("Apple")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.blue)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.blue, lineWidth: 1)
                                    )
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.top)
                        Spacer()
                    }
                    .padding(.top)
                }
                .fullScreenCover(isPresented: $isSuccessful){
                    ContentView()
                }
                .alert("Oops ! Error", isPresented: $showAlert) {
                    Button("Ok", role: .cancel) {
                        showAlert = false
                    }
                } message: {
                    Text(alertMessage)
                }
            }
            .padding()
        }
    }
}

