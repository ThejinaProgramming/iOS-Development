//
//  Person.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/7/25.
//

import Foundation

struct Person: Codable, Identifiable{
    let id: Int
    let name: String
    let email: String
}
