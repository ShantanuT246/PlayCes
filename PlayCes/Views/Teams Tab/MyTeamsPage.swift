import SwiftUI

// MARK: - Data Models
struct Team: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var sport: String
    var members: [TeamMember]
    var color: Color
    var uniqueCode: String = Team.generateUniqueCode() // Random code
    static func generateUniqueCode(length: Int = 6) -> String {
            let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<length).compactMap { _ in characters.randomElement() })
    }
}

struct TeamMember: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var imageName: String
}

// MARK: - Main Teams View
struct MyTeamsPage: View {
    @State private var teams: [Team] = [
        Team(
            name: "FC Warriors",
            sport: "Football",
            members: [
                TeamMember(name: "Alex Johnson", imageName: "person.crop.circle"),
                TeamMember(name: "Sam Wilson", imageName: "person.crop.circle"),
                TeamMember(name: "Jamie Smith", imageName: "person.crop.circle")
            ],
            color: .purple
        ),
        Team(
            name: "Net Kings",
            sport: "Basketball",
            members: [
                TeamMember(name: "Mike Jordan", imageName: "person.crop.circle"),
                TeamMember(name: "Leo James", imageName: "person.crop.circle")
            ],
            color: .orange
        ),
        Team(
            name: "Smash Masters",
            sport: "Badminton",
            members: [
                TeamMember(name: "Wei Chen", imageName: "person.crop.circle"),
                TeamMember(name: "Lisa Wang", imageName: "person.crop.circle")
            ],
            color: .green
        )
    ]
    
    @State private var selectedTeam: Team?
    @State private var showingCreateTeam = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo.opacity(0.25), Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(edges: .top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header section
                        VStack(spacing: 16) {
                            // Top bar with title and create button
                            HStack {
                                Text("My Teams")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Button(action: { showingCreateTeam = true }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(.white)
                                        .padding(8)
                                        .background(.ultraThinMaterial.opacity(0.7))
                                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                }
                            }
                            
                            // Welcome message
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Manage your teams & players")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                Text("Create, organize, and connect with your teams")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.9))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .padding(.top, 0)
                        
                        // Teams grid section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Your Teams")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                                ForEach(teams) { team in
                                    TeamCard(team: team, isSelected: selectedTeam?.id == team.id) {
                                        selectedTeam = team
                                    }
                                }
                                
                                // Add new team card
                                Button(action: { showingCreateTeam = true }) {
                                    VStack(spacing: 12) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.system(size: 32))
                                            .foregroundColor(.blue)
                                        Text("Create New Team")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 160)
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
                        .padding(.horizontal)
                        
                        // Selected team details section
                        if let selectedTeam = selectedTeam {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("Team Details")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Button("Edit") {
                                        // Edit team action
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                }
                                .padding(.horizontal)
                                
                                TeamDetailView(team: selectedTeam)
                                    .padding(.horizontal)
                            }
                            .padding(.vertical)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
                            .padding()
                            .transition(.opacity.combined(with: .scale))
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingCreateTeam) {
                CreateTeamView(teams: $teams, selectedTeam: $selectedTeam)
            }
        }
    }
}

