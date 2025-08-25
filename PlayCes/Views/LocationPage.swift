//import SwiftUI
//import CoreLocation
//
//struct Location: Identifiable, Equatable {
//    let id = UUID()
//    let name: String
//    let area: String?
//    let distance: Double?
//    let coordinate: CLLocationCoordinate2D?
//    var selectedLatitude: Double?
//    var selectedLongitude: Double?
//    
//    // For places with area information
//    init(name: String, area: String, distance: Double, coordinate: CLLocationCoordinate2D) {
//        self.name = name
//        self.area = area
//        self.distance = distance
//        self.coordinate = coordinate
//    }
//    
//    // For cities without area/distance
//    init(name: String) {
//        self.name = name
//        self.area = nil
//        self.distance = nil
//        self.coordinate = nil
//    }
//
//    static func == (lhs: Location, rhs: Location) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
//
//class LocationDataService: ObservableObject {
//    @Published var nearbyPlaces: [Location] = [
//        Location(name: "Elpro City Square Mall", area: "Chinchwad", distance: 4.9, coordinate: CLLocationCoordinate2D(latitude: 18.6298, longitude: 73.7997)),
//        Location(name: "White Square", area: "Hinjawadi", distance: 6.6, coordinate: CLLocationCoordinate2D(latitude: 18.5933, longitude: 73.7376))
//    ]
//    
//    @Published var popularCities: [Location] = [
//        Location(name: "Delhi NCR"),
//        Location(name: "Mumbai"),
//        Location(name: "Kolkata"),
//        Location(name: "Bengaluru"),
//        Location(name: "Hyderabad"),
//        Location(name: "Chandigarh")
//    ]
//    
//    @Published var allCities: [Location] = [
//        Location(name: "Abohar"),
//        Location(name: "Abu Road"),
//        Location(name: "Ahmedabad"),
//        Location(name: "Allahabad"),
//        Location(name: "Amritsar"),
//        Location(name: "Aurangabad")
//    ]
//    
//    @Published var selectedLocation: Location?
//    @Published var selectedLatitude: Double?
//    @Published var selectedLongitude: Double?
//    
//    func searchLocations(query: String) -> [Location] {
//        let allLocations = nearbyPlaces + popularCities + allCities
//        if query.isEmpty { return allLocations }
//        
//        return allLocations.filter { location in
//            location.name.localizedCaseInsensitiveContains(query)
//        }
//    }
//}
//
//struct LocationPage: View {
//    @Environment(\.dismiss) private var dismiss
//    @StateObject private var locationService = LocationDataService()
//    @State private var searchText: String = ""
//    @State private var showingLocationAccessAlert = false
//    @State private var locationAccessGranted = false
//    
//    var body: some View {
//        NavigationStack {
//            VStack(alignment: .leading, spacing: 16) {
//                // Search bar
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.gray)
//                    
//                    TextField("Search city, area or locality", text: $searchText)
//                    
//                    if !searchText.isEmpty {
//                        Button(action: {
//                            searchText = ""
//                        }) {
//                            Image(systemName: "xmark.circle.fill")
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//                .padding(10)
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//                .padding(.horizontal)
//                
//                // Location access prompt
//                if !locationAccessGranted {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Button(action: {
//                            showingLocationAccessAlert = true
//                        }) {
//                            HStack {
//                                Image(systemName: "location.fill")
//                                    .foregroundColor(.blue)
//                                
//                                Text("Allow location access")
//                                    .foregroundColor(.blue)
//                                    .font(.subheadline)
//                                
//                                Spacer()
//                            }
//                        }
//                        
//                        Text("Unable to detect your current location")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .padding(.horizontal)
//                }
//                
//                // Search results or default content
//                if !searchText.isEmpty {
//                    let results = locationService.searchLocations(query: searchText)
//                    
//                    if results.isEmpty {
//                        Text("No results found")
//                            .foregroundColor(.gray)
//                            .padding()
//                            .frame(maxWidth: .infinity, alignment: .center)
//                    } else {
//                        ScrollView {
//                            VStack(spacing: 12) {
//                                ForEach(results) { location in
//                                    LocationRow(location: location, onSelect: { selectLocation($0) })
//                                        .padding()
//                                        .background(Color(.secondarySystemBackground))
//                                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//                                        .padding(.horizontal)
//                                }
//                            }
//                            .padding(.vertical)
//                        }
//                    }
//                    
//                    Spacer()
//                } else {
//                    // Default content when not searching
//                    ScrollView {
//                        VStack(alignment: .leading, spacing: 24) {
//                            // Popular cities
//                            VStack(alignment: .leading, spacing: 12) {
//                                Text("Popular cities")
//                                    .font(.headline)
//                                
//                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 12) {
//                                    ForEach(locationService.popularCities, id: \.self) { city in
//                                        Button(action: {
//                                            selectLocation(city)
//                                        }) {
//                                            Text(city.name)
//                                                .frame(maxWidth: .infinity)
//                                                .padding(.vertical, 12)
//                                                .background(Color(.systemGray6))
//                                                .foregroundColor(.primary)
//                                                .cornerRadius(10)
//                                        }
//                                    }
//                                }
//                            }
//                            .padding()
//                            .background(Color(.secondarySystemBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//            }
//            .navigationTitle("Location")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                }
//            }
//            .alert("Allow Location Access", isPresented: $showingLocationAccessAlert) {
//                Button("Allow") {
//                    // In a real app, you would request location access here
//                    locationAccessGranted = true
//                }
//                Button("Cancel", role: .cancel) {}
//            } message: {
//                Text("This app needs location access to find grounds near you.")
//            }
//        }
//    }
//    
//    private func selectLocation(_ location: Location) {
//        locationService.selectedLocation = location
//        if let coord = location.coordinate {
//            locationService.selectedLatitude = coord.latitude
//            locationService.selectedLongitude = coord.longitude
//        }
//        print("Selected location: \(location.name)")
//        dismiss()
//    }
//}
//
//struct LocationRow: View {
//    let location: Location
//    let onSelect: (Location) -> Void
//    
//    var body: some View {
//        Button(action: {
//            onSelect(location)
//        }) {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(location.name)
//                    .font(.body)
//                    .foregroundColor(.primary)
//                
//                if let area = location.area, let distance = location.distance {
//                    HStack {
//                        Text("\(distance, specifier: "%.1f") km")
//                        Text("|")
//                        Text(area)
//                    }
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                }
//            }
//            .padding(.vertical, 8)
//        }
//    }
//}
//
////#Preview {
////    LocationPage().preferredColorScheme(.dark)
////}
