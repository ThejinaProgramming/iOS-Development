//
//  CustomError.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/7/25.
//

import Foundation

enum CustomError: Error{
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case decodingFailed
}
