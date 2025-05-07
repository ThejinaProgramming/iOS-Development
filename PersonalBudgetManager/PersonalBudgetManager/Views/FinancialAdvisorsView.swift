//
//  FinancialAdvisorsView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/7/25.
//

import SwiftUI

struct FinancialAdvisorsView: View {
    @State private var persons: [Person]?
    @State private var errorDescription: String = "Something went wrong, please try again!"
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Financial Advisors")
                .font(.title2)
                .bold()
                .padding(.bottom)
            
            if let persons = persons{
                List(persons){i in
                    GroupBox{
                        VStack{
                            HStack{
                                Text("Name: " + i.name)
                                Spacer()
                            }
                            
                            HStack{
                                Text("email:" + i.email)
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .listStyle(.plain)
            }
            else{
                ContentUnavailableView("Ooops!", systemImage: "ladybug.fill", description: Text(errorDescription))
            }
        }
        .padding()
        .task {
            do {
                persons = try await fetchUserInfo()
            } catch CustomError.invalidURL {
                errorDescription = "Error: MyCustomError.invalidURL"
            } catch CustomError.invalidResponse {
                errorDescription = "Error: MyCustomError.invalidResponse"
            } catch CustomError.invalidStatusCode {
                errorDescription = "Error: MyCustomError.invalidStatusCode"
            } catch CustomError.decodingFailed {
                errorDescription = "Error: MyCustomError.decodingFailed"
            } catch {
                errorDescription = "Error: Unexpected"
            }
        }
    }
    
    func fetchUserInfo() async throws -> [Person]{
        // step 1 - contruct the url
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else {
            throw CustomError.invalidURL
        }
        
        // step 2 - url session
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // step 3 - if the received response if valid
        guard let response = response as? HTTPURLResponse else {
            throw CustomError.invalidResponse
        }
        
        guard response.statusCode == 200 else {
            throw CustomError.invalidStatusCode
        }
        
        do {
            return try JSONDecoder().decode([Person].self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
}

#Preview {
    FinancialAdvisorsView()
}
