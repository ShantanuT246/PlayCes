//
//  TeamDetailView.swift
//  PlayCes
//
//  Created by Shantanu Tapole on 22/08/25.
//

import SwiftUI

// MARK: - Team Detail View
struct TeamDetailView: View {
    let team: Team
    
    var body: some View {
        VStack(spacing: 16) {
            // Team header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(team.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(team.sport)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Team Code: "+team.uniqueCode)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                }
                
                Spacer()
                
                Circle()
                    .fill(team.color)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(team.name.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.white)
                    )
            }
            
            Divider()
            
            // Members list
            VStack(alignment: .leading, spacing: 12) {
                Text("Team Members (\(team.members.count))")
                    .font(.headline)
                
                ForEach(team.members) { member in
                    HStack {
                        Image(systemName: member.imageName)
                            .font(.title2)
                            .foregroundColor(team.color)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(member.name)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "message")
                                .foregroundColor(team.color)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "person.badge.plus")
                        Text("Add Member")
                    }
                    .foregroundColor(team.color)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            }
            
            // Team actions
            HStack(spacing: 12) {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Schedule")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(team.color.opacity(0.2))
                    .foregroundColor(team.color)
                    .cornerRadius(8)
                }
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "bell")
                        Text("Notify")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(team.color.opacity(0.2))
                    .foregroundColor(team.color)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Team Card View
struct TeamCard: View {
    let team: Team
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Circle()
                        .fill(team.color)
                        .frame(width: 12, height: 12)
                    
                    Text(team.sport)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Image(systemName: "person.2.fill")
                        .foregroundColor(team.color)
                }
                
                Text(team.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                HStack {
                    Text("\(team.members.count) members")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(team.color)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? team.color : Color.clear, lineWidth: 2)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

// MARK: - Create Team View
struct CreateTeamView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var teams: [Team]
    @Binding var selectedTeam: Team?
    
    @State private var teamName = ""
    @State private var selectedSport = "Football"
    @State private var teamColor = Color.blue
    
    let sports = ["Football", "Basketball", "Tennis", "Cricket", "Badminton", "Volleyball"]
    let colors: [Color] = [.blue, .purple, .green, .orange, .pink, .red, .indigo]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Team Information") {
                    TextField("Team Name", text: $teamName)
                    
                    Picker("Sport", selection: $selectedSport) {
                        ForEach(sports, id: \.self) { sport in
                            Text(sport)
                        }
                    }
                }
                
                Section("Team Color") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(teamColor == color ? Color.primary : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    teamColor = color
                                }
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section {
                    Button("Create Team") {
                        let newTeam = Team(
                            name: teamName,
                            sport: selectedSport,
                            members: [],
                            color: teamColor
                        )
                        teams.append(newTeam)
                        selectedTeam = newTeam
                        dismiss()
                    }
                    .disabled(teamName.isEmpty)
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Create New Team")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
