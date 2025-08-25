//
//  SearchPage.swift
//  PlayCes
//
//  Created by Shantanu Tapole on 21/08/25.
//

import SwiftUI

struct SearchPage: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.25), Color.clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(edges: .top)
            
            VStack {
                Text("Welcome to Search Page")
                    .font(.title)
                    .padding()
                
                NavigationLink("Go to Details", destination: Text("Details Page"))
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
        }
    }
}
