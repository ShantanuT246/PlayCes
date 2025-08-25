import SwiftUI

// MARK: - Data Models
struct Booking: Identifiable, Hashable {
    let id = UUID()
    var venueName: String
    var sport: String
    var date: Date
    var duration: String
    var price: Double
    var status: BookingStatus
    var imageName: String
    var participants: Int
}

enum BookingStatus {
    case upcoming, completed, cancelled
    
    var title: String {
        switch self {
        case .upcoming: return "Upcoming"
        case .completed: return "Completed"
        case .cancelled: return "Cancelled"
        }
    }
    
    var color: Color {
        switch self {
        case .upcoming: return .green
        case .completed: return .blue
        case .cancelled: return .red
        }
    }
}

// MARK: - Main Bookings View
struct MyBookingsPage: View {
    @State private var selectedFilter = 0
    @State private var bookings: [Booking] = [
        // Upcoming bookings
        Booking(
            venueName: "City Sports Complex",
            sport: "Football",
            date: Date().addingTimeInterval(86400 * 2), // 2 days from now
            duration: "2 hours",
            price: 1200,
            status: .upcoming,
            imageName: Self.sfSymbol(for: "Football"),
            participants: 10
        ),
        Booking(
            venueName: "Elite Tennis Academy",
            sport: "Tennis",
            date: Date().addingTimeInterval(86400 * 5), // 5 days from now
            duration: "1.5 hours",
            price: 800,
            status: .upcoming,
            imageName: Self.sfSymbol(for: "Tennis"),
            participants: 2
        ),
        
        // Completed bookings
        Booking(
            venueName: "Ravet Community Ground",
            sport: "Cricket",
            date: Date().addingTimeInterval(-86400 * 3), // 3 days ago
            duration: "3 hours",
            price: 1500,
            status: .completed,
            imageName: Self.sfSymbol(for: "Cricket"),
            participants: 16
        ),
        Booking(
            venueName: "Skyline Basketball Court",
            sport: "Basketball",
            date: Date().addingTimeInterval(-86400 * 7), // 7 days ago
            duration: "2 hours",
            price: 900,
            status: .completed,
            imageName: Self.sfSymbol(for: "Basketball"),
            participants: 8
        ),
        
        // Cancelled booking
        Booking(
            venueName: "Pune Cricket Ground",
            sport: "Cricket",
            date: Date().addingTimeInterval(-86400 * 1), // 1 day ago
            duration: "4 hours",
            price: 2000,
            status: .cancelled,
            imageName: Self.sfSymbol(for: "Cricket"),
            participants: 0
        )
    ]

    private static func sfSymbol(for sport: String) -> String {
        switch sport {
        case "Football":
            return "sportscourt"
        case "Tennis":
            return "tennis.racket"
        case "Cricket":
            return "cricket.ball"
        case "Basketball":
            return "basketball"
        default:
            return "sportscourt"
        }
    }
    
    private var upcomingBookings: [Booking] {
        bookings.filter { $0.status == .upcoming }.sorted { $0.date < $1.date }
    }
    
    private var previousBookings: [Booking] {
        bookings.filter { $0.status != .upcoming }.sorted { $0.date > $1.date }
    }
    
    private var filteredBookings: [Booking] {
        switch selectedFilter {
        case 0: return upcomingBookings
        case 1: return previousBookings
        default: return []
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.mint.opacity(0.25), Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(edges: .top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header section
                        VStack(spacing: 16) {
                            // Top bar with title and profile
                            Text("My Bookings")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Welcome message
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Manage your bookings")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                Text("View upcoming matches and booking history")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.9))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .padding(.top, 0)
                        
                        // Filter section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Bookings")
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    FilterPill(
                                        title: "Upcoming",
                                        isSelected: selectedFilter == 0,
                                        iconName: "calendar",
                                        activeBackgroundColor: Color.mint.opacity(0.6),
                                        activeTextColor: Color.white
                                    ) {
                                        selectedFilter = 0
                                    }
                                    
                                    FilterPill(
                                        title: "Previous",
                                        isSelected: selectedFilter == 1,
                                        iconName: "clock.arrow.circlepath",
                                        activeBackgroundColor: Color.blue.opacity(0.6),
                                        activeTextColor: Color.white
                                    ) {
                                        selectedFilter = 1
                                    }
                                    
                                    FilterPill(
                                        title: "Cancelled",
                                        isSelected: selectedFilter == 2,
                                        iconName: "xmark.circle",
                                        activeBackgroundColor: Color.red.opacity(0.6),
                                        activeTextColor: Color.white
                                    ) {
                                        selectedFilter = 2
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
                        
                        // Bookings list
                        VStack(alignment: .leading, spacing: 16) {
                            if filteredBookings.isEmpty {
                                EmptyBookingsView(status: selectedFilter)
                            } else {
                                Text(selectedFilter == 0 ? "Upcoming Bookings" : "Previous Bookings")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal)
                                
                                LazyVStack(spacing: 16) {
                                    ForEach(filteredBookings) { booking in
                                        BookingCard(booking: booking)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
                        .padding()
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




