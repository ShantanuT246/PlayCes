import SwiftUI
import CoreLocation

struct HomePage: View {
    private let sampleUser = UserProfile.sampleProfileForHome
    @State private var search: String = ""
    @State private var selectedSport = 0
    @State private var selectedDate = 0
    @State private var selectedPrice = 0
    @State private var showingFilters = false
    
    // Sample data for demonstration
    private let sports = ["All", "Football", "Basketball", "Tennis", "Cricket", "Badminton"]
    private let price = ["All","Under ₹500", "₹500 - ₹1000", "₹1000 - ₹2000", "Over ₹2000"]
    private let availableVenues = Venue.sampleVenues
    
    private var filteredVenues: [Venue] {
        let venues = availableVenues.filter { venue in
            let matchesSport = selectedSport == 0 || venue.sports.contains(sports[selectedSport])
            
            let matchesPrice: Bool
            switch selectedPrice {
            case 0: matchesPrice = true
            case 1: matchesPrice = venue.hourlyRate < 500
            case 2: matchesPrice = venue.hourlyRate >= 500 && venue.hourlyRate <= 1000
            case 3: matchesPrice = venue.hourlyRate > 1000 && venue.hourlyRate <= 2000
            case 4: matchesPrice = venue.hourlyRate > 2000
            default: matchesPrice = true
            }
            
            return matchesSport && matchesPrice
        }
        
        return venues
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header section (will scroll with content)
                    VStack(spacing: 16) {
                        // Top bar with location and profile
                        HStack {
                            NavigationLink(destination: LocationPage()) {
                                HStack(alignment: .center, spacing: 8) {
                                    Image(systemName: "location.fill")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundStyle(.white)
                                    let location = sampleUser.location
                                    Text("\(location.town)")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("\(location.city ?? ""), \(location.country)")
                                        .fontWeight(.light)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 10))
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(.ultraThinMaterial.opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: ProfilePage()) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .background(.ultraThinMaterial.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                            
                            NavigationLink(destination: FavoritePage()) {
                                Image(systemName: "heart")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.red)
                                    .padding(8)
                                    .background(.ultraThinMaterial.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                        }
                        
                        // Welcome message
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Find Your Perfect Playground")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            Text("Book sports facilities in just a few taps")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.9))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Search bar
                        NavigationLink(destination: SearchPage()) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white.opacity(0.7))
                                Text("Search venues or sports")
                                    .foregroundColor(.white.opacity(0.7))
                                Spacer()
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(.ultraThinMaterial.opacity(0.7))
                            .cornerRadius(10)
                            .foregroundStyle(.white.opacity(0.8))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                    .padding(.top, 0)
                    
                    // Quick filters section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sports")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<sports.count, id: \.self) { index in
                                    FilterPill(
                                        title: sports[index],
                                        isSelected: index == selectedSport,
                                        iconName: iconForSport(sports[index]),
                                        activeBackgroundColor: Color.blue.opacity(0.5),
                                        activeTextColor: Color.white
                                    ) {
                                        selectedSport = index
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("Price Range")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<price.count, id: \.self) { index in
                                    FilterPill(
                                        title: price[index],
                                        isSelected: index == selectedPrice,
                                        activeBackgroundColor: Color.red.opacity(0.6),
                                        activeTextColor: Color.white
                                    ) {
                                        selectedPrice = index
                                    }
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
                    
                    Spacer()
                    Spacer()
                    
                    // Available venues section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Available Venues")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Button("See All") {
                                // Action for see all
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                        
                        LazyVStack(spacing: 16) {
                            if filteredVenues.isEmpty {
                                Text("No results found")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding()
                            } else {
                                ForEach(filteredVenues, id: \.id) { venue in
                                    VenueCard(venue: venue)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.cyan.opacity(0.3), lineWidth: 1)
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .background(Color(.systemBackground))
                }
            }
            //MARK: - Background Gradient
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.cyan.opacity(0.25), Color.clear]),
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea(edges: .top)
            )
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingFilters) {
                FiltersView(selectedSport: $selectedSport, selectedPrice: $selectedPrice)
                    .presentationDetents([.medium, .large])
            }
        }
    }
    
    private func iconForSport(_ sport: String) -> String {
        switch sport {
        case "Football": return "soccerball"
        case "Basketball": return "basketball"
        case "Tennis": return "tennis.racket"
        case "Cricket": return "cricket.ball"
        case "Badminton": return "figure.badminton"
        default: return "sportscourt"
        }
    }
}

// Supporting Views
struct FilterPill: View {
    let title: String
    let isSelected: Bool
    var iconName: String? = nil
    var activeBackgroundColor: Color = Color.blue
    var activeTextColor: Color = Color.white
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .font(.system(size: 14, weight: .medium))
                }
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .foregroundColor(isSelected ? activeTextColor : .primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? activeBackgroundColor : Color(.systemGray5))
            .clipShape(Capsule())
        }
    }
}


struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedSport: Int
    @Binding var selectedPrice: Int
    
    private let sports = ["All", "Football", "Basketball", "Tennis", "Cricket", "Badminton"]
    private let price = ["All","Under ₹500", "₹500 - ₹1000", "₹1000 - ₹2000", "Over ₹2000"]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Sports Type") {
                    ForEach(0..<sports.count, id: \.self) { index in
                        FilterRow(title: sports[index], isSelected: selectedSport == index) {
                            selectedSport = index
                        }
                    }
                }
                
                Section("Price Range") {
                    ForEach(0..<price.count, id: \.self) { index in
                        FilterRow(title: price[index], isSelected: selectedPrice == index) {
                            selectedPrice = index
                        }
                    }
                }
                
                Section("Facilities") {
                    // Filter options would go here
                    Text("Lighting")
                    Text("Changing Rooms")
                    Text("Equipment Rental")
                    Text("Parking")
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FilterRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
