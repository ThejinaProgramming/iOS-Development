//
//  InitialView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/27/25.
//

import SwiftUI

struct InitialView: View {
    @StateObject private var signVM = SignViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                //backgroung color
                Color.blue
                    .ignoresSafeArea()
                
                
                VStack{
                    //App Logo
                    Image("LOGO1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding(.top, 100)
                                    
                    //App name
                    Text("Personal Budget Manager")
                        .font(.title).bold()
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    //Description
                    Text("Manage your finance with ease")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.top, 8)
                    
                    Spacer()
                    
                    NavigationLink(destination: SignView(signViewModel: signVM)) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(25)
                            .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
        }
    }
}

