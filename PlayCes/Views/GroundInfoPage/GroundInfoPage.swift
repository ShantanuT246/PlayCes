import SwiftUI
import MapKit
import CoreLocation
// Uses Venue model and sample venues from SampleVenues.swift
// Venue Model

struct VenueDetailView: View {
    let venue: Venue
    @State private var selectedTab = 0
    @State private var isFavorited: Bool = false
    @State private var selectedDate = Date()
    @State private var selectedHours = 1
    @State private var showingBookingSheet = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Image Carousel
                ZStack(alignment: .topLeading) {
                    TabView(selection: $selectedTab) {
                        ForEach(0..<venue.images.count, id: \.self) { index in
                            Image(venue.images[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: 300)
                                .clipped()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 300)
                    .overlay(
                        // Page Indicator
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("\(selectedTab + 1)/\(venue.images.count)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color.black.opacity(0.6))
                                    .clipShape(Capsule())
                                    .padding(.trailing, 16)
                                    .padding(.bottom, 16)
                            }
                        }
                    )
                    .background(Color.cyan.opacity(0.15))
                    
                    
                    // Favorite Button
                    HStack {
                        Spacer()
                        Button(action: {
                            isFavorited.toggle()
                        }) {
                            Image(systemName: isFavorited ? "heart.fill" : "heart")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.red)
                                .padding(8)
                                .background(.thinMaterial)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 16)
                        .padding(.top, 70)
                    }
                }
                
                // Venue Info Section
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Rating
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(venue.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.orange)
                                
                                Text(String(format: "%.1f", venue.rating))
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Text("(\(venue.reviewCount) reviews)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        // Price
                        VStack(alignment: .trailing) {
                            Text("₹\(String(format: "%.0f", venue.hourlyRate))")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.cyan)
                            
                            Text("/ hour")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Location (compact card style)
                    VStack {
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.cyan)
                            Text(venue.address)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }

                    VStack {
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.cyan)
                            Text(venue.hours)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    
                    // Sports
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Sports")
                            .font(.headline)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 12) {
                            ForEach(venue.sports, id: \.self) { sport in
                                HStack {
                                    Image(systemName: sportsIcons[sport] ?? "questionmark.circle")
                                        .foregroundColor(.cyan)
                                        .frame(width: 24)
                                    Text(sport)
                                        .font(.subheadline)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Amenities
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Amenities")
                            .font(.headline)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 12) {
                            ForEach(venue.amenities, id: \.self) { amenity in
                                HStack {
                                    Image(systemName: amenityIcons[amenity] ?? "questionmark.circle")
                                        .foregroundColor(.cyan)
                                        .frame(width: 24)
                                    Text(amenity)
                                        .font(.subheadline)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                showingBookingSheet = true
                            }) {
                                HStack {
                                    Text("Book Now")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Image(systemName: "arrow.right")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.cyan)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                        .background(
                            Color(.systemBackground)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -3)
                        )
                    }
                    
                .sheet(isPresented: $showingBookingSheet) {
                    BookingView(venue: venue)
                }
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)
                        
                        Text(venue.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Divider()
                    
                    // Map
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Location Map")
                            .font(.headline)
                        
                        MapView(location: venue.locationCoordinate)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    // Function to open address in Maps
    private func openMaps(address: String) {
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "http://maps.apple.com/?address=\(encodedAddress)") {
            UIApplication.shared.open(url)
        }
    }
    
    // Amenity icons mapping
    private let amenityIcons: [String: String] = [
        "Wi-Fi": "wifi",
        "Parking": "car.fill",
        "Changing Rooms": "person.crop.circle",
        "Seating": "chair",
        "Water": "drop.fill",
        "Restrooms": "toilet"
    ]
    // Sports icons mapping
    private let sportsIcons: [String: String] = [
        "Cricket": "figure.cricket",
        "Football": "figure.indoor.soccer",
        "Badminton": "figure.badminton",
        "Tennis": "figure.tennis",
        "Basketball": "figure.basketball",
        "Table Tennis": "figure.table.tennis"
    ]
}

// Map View for showing venue location
struct MapView: UIViewRepresentable {
    let location: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        uiView.setRegion(region, animated: true)
        
        // Add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        uiView.addAnnotation(annotation)
    }
}

// Booking View
struct BookingView: View {
    let venue: Venue
    @State private var selectedDate = Date()
    @State private var selectedHours = 1
    @State private var showingConfirmation = false
    @Environment(\.dismiss) var dismiss
    
    var totalPrice: Int {
        Int(venue.hourlyRate) * selectedHours
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Booking Details") {
                    DatePicker("Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                    
                    Stepper(value: $selectedHours, in: 1...8) {
                        HStack {
                            Text("Hours")
                            Spacer()
                            Text("\(selectedHours)")
                                .foregroundColor(.cyan)
                        }
                    }
                    
                    HStack {
                        Text("Total Price")
                        Spacer()
                        Text("₹\(totalPrice)")
                            .font(.headline)
                            .foregroundColor(.cyan)
                    }
                }
                
                Section("Venue Information") {
                    HStack {
                        Text("Hourly Rate")
                        Spacer()
                        Text("₹\(Int(venue.hourlyRate))")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Address")
                        Spacer()
                        Text(venue.address)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Book \(venue.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                        // Handle booking confirmation
                        showingConfirmation = true
                    }
                    .disabled(selectedHours < 1)
                }
            }
            .alert("Booking Confirmed", isPresented: $showingConfirmation) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Your booking at \(venue.name) for \(selectedHours) hour(s) on \(formattedDate(selectedDate)) has been confirmed.")
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}



struct VenueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VenueDetailView(venue: Venue.sampleVenues.first!).preferredColorScheme(.dark)
    }
}
