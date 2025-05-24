//
//  InitialView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/27/25.
//

import SwiftUI

struct InitialView: View {
    @StateObject private var signVM = SignViewModel()
    
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var buttonOpacity: Double = 0.0
    
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
                        .padding(.top, 130)
                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.5)) {
                                logoScale = 1.0
                                logoOpacity = 1.0
                            }
                            
                            withAnimation(.easeIn(duration: 0.8).delay(1.5)) {
                                textOpacity = 1.0
                            }
                            
                            withAnimation(.easeIn(duration: 0.8).delay(1.6)) {
                                buttonOpacity = 1.0
                            }
                        }
                                    
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

