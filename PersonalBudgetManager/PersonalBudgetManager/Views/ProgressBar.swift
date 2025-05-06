//
//  ProgressBar.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

// Helper view for Dashboard
struct ProgressBar: View {
    
    
    let value: CGFloat
    
    var body: some View {
        GeometryReader{geometry in
            ZStack(alignment: .leading){
                Rectangle().frame(width: geometry.size.width, height: 8)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                Rectangle().frame(width: min(self.value * geometry.size.width, geometry.size.width), height: 8).foregroundColor(Color.blue)
            }
        }
        .frame(height: 8)
    }
}

#Preview {
    ProgressBar(value: 0.6)
}
