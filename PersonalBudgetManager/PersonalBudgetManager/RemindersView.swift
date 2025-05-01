//
//  RemindersView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct RemindersView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Reminders")
                .font(.title2)
                .bold()
                .padding(.bottom)
            
            List{
                ReminderRow(title: "Pay Phone Bill")
                ReminderRow(title: "Pay Light Bill")
                ReminderRow(title: "Pay University Fee")
                ReminderRow(title: "Donate Money")
            }
            Spacer()
            
            Button(action: {
                
            }){
                Image(systemName: "plus")
                    .font(.title)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
        .padding()
    }
}

#Preview {
    RemindersView()
}
