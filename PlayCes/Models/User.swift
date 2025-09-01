//
//  User.swift
//  PlayCes
//
//  Created by Shantanu Tapole on 25/08/25.
//

import Foundation
import CoreLocation

// MARK: - Location Model
struct Location: Codable, Identifiable, Equatable {
    let id = UUID()
    var town: String
    var city: String?
    var country: String
    var coordinate: CLLocationCoordinate2D?
    
    // Custom coding keys to handle CLLocationCoordinate2D
    enum CodingKeys: String, CodingKey {
        case town, city, country, latitude, longitude
    }
    
    init(town: String, city: String?, country: String, coordinate: CLLocationCoordinate2D?) {
        self.town = town
        self.city = city
        self.country = country
        self.coordinate = coordinate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        town = try container.decode(String.self, forKey: .town)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        country = try container.decode(String.self, forKey: .country)
        
        if let latitude = try container.decodeIfPresent(Double.self, forKey: .latitude),
           let longitude = try container.decodeIfPresent(Double.self, forKey: .longitude) {
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            coordinate = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(town, forKey: .town)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encode(country, forKey: .country)
        try container.encode(coordinate?.latitude, forKey: .latitude)
        try container.encode(coordinate?.longitude, forKey: .longitude)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id &&
        lhs.town == rhs.town &&
        lhs.city == rhs.city &&
        lhs.country == rhs.country &&
        lhs.coordinate?.latitude == rhs.coordinate?.latitude &&
        lhs.coordinate?.longitude == rhs.coordinate?.longitude
    }
}

// MARK: - User Profile Model
struct UserProfile: Codable, Identifiable {
    let id: UUID
    var name: String
    var email: String
    var phone: String
    var location: Location
    var memberSince: Date
    var profileImageUrl: String?
    var sports: [String]
    var stats: UserStats
}

// MARK: - User Stats Model
struct UserStats: Codable {
    var gamesPlayed: Int
    var hoursPlayed: Int
    var favoriteSport: String
    var achievements: [Achievement]
}

// MARK: - Achievement Model
struct Achievement: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let iconName: String
    let dateEarned: Date
}

// MARK: - Sample Data (Optional)
extension UserProfile {
    static let sample = UserProfile(
        id: UUID(),
        name: "Alex Johnson",
        email: "alex.johnson@example.com",
        phone: "+1 (555) 123-4567",
        location: Location(
            town: "Pune",
            city: "Pune",
            country: "India",
            coordinate: CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567)
        ),
        memberSince: Date().addingTimeInterval(-365 * 86400),
        profileImageUrl: nil,
        sports: ["Football", "Basketball", "Tennis"],
        stats: UserStats(
            gamesPlayed: 42,
            hoursPlayed: 128,
            favoriteSport: "Football",
            achievements: [
                Achievement(
                    id: UUID(),
                    title: "First Game",
                    description: "Played your first game",
                    iconName: "trophy",
                    dateEarned: Date().addingTimeInterval(-350 * 86400)
                )
            ]
        )
    )
}

extension UserProfile {
    static let sampleProfileForHome = UserProfile(
        id: UUID(),
        name: "Shantanu Tapole",
        email: "shantanu.tapole@example.com",
        phone: "+91 9876543210",
        location: Location(
            town: "Baner",
            city: "Pune",
            country: "India",
            coordinate: CLLocationCoordinate2D(latitude: 18.5590, longitude: 73.7898)
        ),
        memberSince: Date().addingTimeInterval(-200 * 86400),
        profileImageUrl: nil,
        sports: ["Cricket", "Badminton"],
        stats: UserStats(
            gamesPlayed: 15,
            hoursPlayed: 48,
            favoriteSport: "Cricket",
            achievements: [
                Achievement(
                    id: UUID(),
                    title: "Starter",
                    description: "Joined PlayCes and set up your profile",
                    iconName: "person.crop.circle",
                    dateEarned: Date().addingTimeInterval(-180 * 86400)
                )
            ]
        )
    )
}
