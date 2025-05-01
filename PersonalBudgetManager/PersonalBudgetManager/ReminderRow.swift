//
//  ReminderRow.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/2/25.
//

import SwiftUI

struct ReminderRow: View {
    let title:String
    
    var body: some View {
        HStack{
            Image(systemName: "bell.fill")
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ReminderRow(title: "test")
}
