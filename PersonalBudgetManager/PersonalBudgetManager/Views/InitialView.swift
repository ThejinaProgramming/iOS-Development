//
//  InitialView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/27/25.
//

import SwiftUI

struct InitialView: View {
    @ObservedObject var reminderVM : ReminderViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                //App Logo
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 150)
                    .overlay(
                        Text("PersonalWallet")
                            .foregroundColor(.black)
                    )
                
                //App name
                Text("Personal Budget Manager")
                    .font(.title).bold()
                    .padding(.top)
                
                //Description
                Text("Manage your finance with easy")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
            }
            
            NavigationLink(destination: SignView(reminderVM: reminderVM)) {
                Text("Go Inside...")
            }.padding(.top)
        }
    }
}

