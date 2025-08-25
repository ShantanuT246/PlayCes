import SwiftUI

// MARK: - Data Models
struct UserProfile: Codable, Identifiable {
    let id: UUID
    var name: String
    var email: String
    var phone: String
    var location: String
    var memberSince: Date
    var profileImageUrl: String?
    var sports: [String]
    var stats: UserStats
}

struct UserStats: Codable {
    var gamesPlayed: Int
    var hoursPlayed: Int
    var favoriteSport: String
    var achievements: [Achievement]
}

struct Achievement: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let iconName: String
    let dateEarned: Date
}

// MARK: - Profile View Model
class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Sample data - in a real app, this would come from an API
    private let sampleProfile = UserProfile(
        id: UUID(),
        name: "Alex Johnson",
        email: "alex.johnson@example.com",
        phone: "+1 (555) 123-4567",
        location: "Pune, India",
        memberSince: Date().addingTimeInterval(-365 * 86400), // 1 year ago
        profileImageUrl: "https://example.com/profile.jpg",
        sports: ["Football", "Basketball", "Tennis"],
        stats: UserStats(
            gamesPlayed: 42,
            hoursPlayed: 128,
            favoriteSport: "Football",
            achievements: [
                Achievement(
                    id: UUID(),
                    title: "First Game",
                    description: "Played your first game on PlayCes",
                    iconName: "trophy",
                    dateEarned: Date().addingTimeInterval(-350 * 86400)
                ),
                Achievement(
                    id: UUID(),
                    title: "Team Player",
                    description: "Joined your first team",
                    iconName: "person.3",
                    dateEarned: Date().addingTimeInterval(-300 * 86400)
                ),
                Achievement(
                    id: UUID(),
                    title: "Regular",
                    description: "Played 10+ games",
                    iconName: "flame",
                    dateEarned: Date().addingTimeInterval(-200 * 86400)
                )
            ]
        )
    )
    
    func fetchUserProfile() {
        isLoading = true
        errorMessage = nil
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.userProfile = self.sampleProfile
            self.isLoading = false
        }
    }
    
    func updateProfile(_ profile: UserProfile) {
        // In a real app, this would send data to an API
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.userProfile = profile
            self.isLoading = false
        }
    }
}

// MARK: - Main Profile View
struct ProfilePage: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showingEditProfile = false
    @State private var showingSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.25), Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(edges: .top)
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.blue)
                } else if let userProfile = viewModel.userProfile {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            // Header section with profile
                            VStack(spacing: 16) {
                                // Top bar with title and settings
                                HStack {
                                    Text("Profile")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                }
                                
                                // Profile card
                                VStack(spacing: 16) {
                                    // Profile image with edit button
                                    ZStack(alignment: .bottomTrailing) {
                                        AsyncImage(url: URL(string: userProfile.profileImageUrl ?? "")) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(Circle())
                                            } else if phase.error != nil {
                                                Image(systemName: "person.crop.circle.fill")
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 100, height: 100)
                                                    .foregroundColor(.gray)
                                            } else {
                                                ProgressView()
                                                    .frame(width: 100, height: 100)
                                            }
                                        }
                                        .frame(width: 100, height: 100)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                        .shadow(radius: 5)
                                        
                                        Button(action: { showingEditProfile = true }) {
                                            Image(systemName: "pencil.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                                .background(Circle().fill(Color.blue))
                                        }
                                        .offset(x: -5, y: -5)
                                    }
                                    
                                    VStack(spacing: 4) {
                                        Text(userProfile.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                        
                                        Text(userProfile.email)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .background(.ultraThinMaterial.opacity(0.7))
                                .cornerRadius(20)
                            }
                            .padding()
                            .padding(.top, 0)
                            
                            // Stats section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Activity Stats")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal)
                                
                                HStack(spacing: 16) {
                                    StatCard(value: "\(userProfile.stats.gamesPlayed)", label: "Games", icon: "number", color: .blue)
                                    StatCard(value: "\(userProfile.stats.hoursPlayed)", label: "Hours", icon: "clock", color: .green)
                                    StatCard(value: userProfile.stats.favoriteSport, label: "Favorite", icon: "heart", color: .red)
                                }
                                .padding(.horizontal)
                            }
                            .padding(.vertical)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
                            .padding(.horizontal)
                            
                            // Personal info section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Personal Information")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal)
                                
                                InfoRow(icon: "phone", label: "Phone", value: userProfile.phone)
                                InfoRow(icon: "location", label: "Location", value: userProfile.location)
                                
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.blue)
                                        .frame(width: 24)
                                    Text("Member since")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(memberSinceFormatter.string(from: userProfile.memberSince))
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                InfoRow(icon: "sportscourt", label: "Sports", value: userProfile.sports.joined(separator: ", "))
                            }
                            .padding(.vertical)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
                            .padding()
                            
                            // Achievements section
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("Achievements")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Text("\(userProfile.stats.achievements.count)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Capsule().fill(Color.blue))
                                }
                                .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(userProfile.stats.achievements) { achievement in
                                            AchievementCard(achievement: achievement)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.vertical)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
                            .padding(.horizontal)
                            
                            // Logout button
                            Button(action: {}) {
                                Text("Log Out")
                                    .font(.headline)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.red.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            .padding()
                        }
                    }
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                        
                        Text("Error Loading Profile")
                            .font(.headline)
                        
                        Text(error)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("Try Again") {
                            viewModel.fetchUserProfile()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingEditProfile) {
                if let profile = viewModel.userProfile {
                    EditProfileView(profile: profile, viewModel: viewModel)
                }
            }
            .onAppear {
                if viewModel.userProfile == nil {
                    viewModel.fetchUserProfile()
                }
            }
        }
    }
    
    private var memberSinceFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct AchievementCard: View {
    let achievement: Achievement
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: achievement.iconName)
                .font(.title2)
                .foregroundColor(.blue)
                .padding(10)
                .background(Circle().fill(Color.blue.opacity(0.2)))
            
            Text(achievement.title)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(dateFormatter.string(from: achievement.dateEarned))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 120, height: 140)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Edit Profile View
struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State var profile: UserProfile
    let viewModel: ProfileViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("Name", text: $profile.name)
                    TextField("Email", text: $profile.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone", text: $profile.phone)
                    TextField("Location", text: $profile.location)
                }
                
                Section {
                    Button("Save Changes") {
                        viewModel.updateProfile(profile)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Edit Profile")
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
