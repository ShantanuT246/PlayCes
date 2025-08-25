// SampleVenues.swift
import Foundation
import CoreLocation

// Reuse your existing Venue model
struct Venue {
    let id = UUID()
    let name: String
    let description: String
    let rating: Double
    let distance: Double
    let hourlyRate: Double
    let reviewCount: Int
    let address: String
    let hours: String
    let sports: [String]
    let amenities: [String]
    let images: [String]
    let locationCoordinate: CLLocationCoordinate2D
}

extension Venue {
    static let sampleVenues: [Venue] = [
        Venue(
            name: "City Sports Complex",
            description: "A premium sports complex with turf, floodlights, and modern facilities. Great for training and matches.",
            rating: 4.8,
            distance: 2.5,
            hourlyRate: 800,
            reviewCount: 128,
            address: "123 Sports Avenue, Ravet, Pune",
            hours: "6:00 AM - 10:00 PM (Mon - Sun)",
            sports: ["Cricket", "Football"],
            amenities: ["Wi-Fi", "Parking", "Changing Rooms", "Seating", "Water", "Restrooms"],
            images: ["sample1", "sample2"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.6510, longitude: 73.7617)
        ),
        Venue(
            name: "Ravet Community Ground",
            description: "Open community ground with well-maintained pitches and basic amenities. Suitable for casual matches.",
            rating: 4.6,
            distance: 3.2,
            hourlyRate: 500,
            reviewCount: 89,
            address: "45 Green Park, Ravet, Pune",
            hours: "5:30 AM - 9:00 PM (Mon - Sun)",
            sports: ["Cricket", "Football"],
            amenities: ["Parking", "Restrooms"],
            images: ["sample2", "sample1"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.6525, longitude: 73.7650)
        ),
        Venue(
            name: "Elite Indoor Arena",
            description: "Indoor multi-sport arena with professional flooring, seating, and changing rooms.",
            rating: 4.9,
            distance: 1.8,
            hourlyRate: 1200,
            reviewCount: 210,
            address: "9 Prestige Towers, Baner, Pune",
            hours: "7:00 AM - 11:00 PM (Mon - Sun)",
            sports: ["Badminton", "Basketball", "Table Tennis"],
            amenities: ["Wi-Fi", "Parking", "Changing Rooms", "Seating", "Water", "Restrooms"],
            images: ["sample1", "sample2"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5590, longitude: 73.7795)
        ),
        Venue(
            name: "Greenfield Tennis Courts",
            description: "Outdoor tennis courts with professional-grade surfaces and floodlights for night play.",
            rating: 4.7,
            distance: 4.1,
            hourlyRate: 700,
            reviewCount: 74,
            address: "78 Greenfield Road, Kothrud, Pune",
            hours: "6:00 AM - 9:00 PM (Mon - Sat)",
            sports: ["Tennis"],
            amenities: ["Parking", "Restrooms", "Water"],
            images: ["sample3", "sample4"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5167, longitude: 73.8567)
        ),
        Venue(
            name: "Sunrise Yoga Studio",
            description: "Peaceful indoor studio offering yoga and meditation classes with serene ambiance.",
            rating: 4.5,
            distance: 3.8,
            hourlyRate: 600,
            reviewCount: 56,
            address: "22 Sunrise Lane, Viman Nagar, Pune",
            hours: "5:00 AM - 8:00 PM (Mon - Fri)",
            sports: ["Yoga", "Meditation"],
            amenities: ["Wi-Fi", "Changing Rooms", "Seating"],
            images: ["sample1", "sample3"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5600, longitude: 73.9120)
        ),
        Venue(
            name: "Downtown Basketball Court",
            description: "Open-air basketball court in the heart of the city, popular among local players.",
            rating: 4.3,
            distance: 2.0,
            hourlyRate: 300,
            reviewCount: 102,
            address: "10 Main Street, Shivaji Nagar, Pune",
            hours: "6:00 AM - 10:00 PM (Mon - Sun)",
            sports: ["Basketball"],
            amenities: ["Seating", "Water", "Restrooms"],
            images: ["sample4", "sample2"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567)
        ),
        Venue(
            name: "Riverside Running Track",
            description: "Scenic running track along the river with dedicated lanes and fitness stations.",
            rating: 4.4,
            distance: 5.5,
            hourlyRate: 200,
            reviewCount: 150,
            address: "Riverside Park, Hadapsar, Pune",
            hours: "5:00 AM - 9:00 PM (Mon - Sun)",
            sports: ["Running", "Jogging"],
            amenities: ["Water", "Seating", "Restrooms"],
            images: ["sample3", "sample2"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5300, longitude: 73.9300)
        ),
        Venue(
            name: "Mountain View Climbing Gym",
            description: "Indoor climbing gym with walls for all skill levels and professional trainers available.",
            rating: 4.9,
            distance: 6.0,
            hourlyRate: 1000,
            reviewCount: 85,
            address: "55 Hilltop Road, Pashan, Pune",
            hours: "8:00 AM - 10:00 PM (Mon - Sat)",
            sports: ["Climbing"],
            amenities: ["Wi-Fi", "Changing Rooms", "Seating", "Water", "Restrooms"],
            images: ["sample2", "sample4"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5605, longitude: 73.7800)
        ),
        Venue(
            name: "Lakeside Paddle Club",
            description: "Picturesque lakeside venue offering kayaking, canoeing, and paddleboarding with rental equipment and instructors.",
            rating: 4.2,
            distance: 7.3,
            hourlyRate: 900,
            reviewCount: 47,
            address: "Lakeview Drive, Mulshi, Pune",
            hours: "7:00 AM - 7:00 PM (Mon - Sun)",
            sports: ["Kayaking", "Canoeing", "Paddleboarding"],
            amenities: ["Parking", "Changing Rooms", "Equipment Rental", "Restrooms"],
            images: ["sample1", "sample4"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5050, longitude: 73.4950)
        ),
        Venue(
            name: "Urban Skating Park",
            description: "Modern skatepark with ramps, rails, and bowls suitable for skateboarding, inline skating, and BMX.",
            rating: 4.6,
            distance: 4.9,
            hourlyRate: 350,
            reviewCount: 64,
            address: "88 Skate Lane, Aundh, Pune",
            hours: "4:00 PM - 10:00 PM (Mon - Sun)",
            sports: ["Skateboarding", "Inline Skating", "BMX"],
            amenities: ["Seating", "Water", "Restrooms", "Parking"],
            images: ["sample1", "sample4"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5630, longitude: 73.8070)
        ),
        Venue(
            name: "Heritage Martial Arts Dojo",
            description: "Traditional dojo offering karate, judo, and taekwondo classes for all ages and skill levels.",
            rating: 4.8,
            distance: 3.1,
            hourlyRate: 700,
            reviewCount: 92,
            address: "12 Heritage Plaza, Kalyani Nagar, Pune",
            hours: "6:00 AM - 9:00 PM (Mon - Sat)",
            sports: ["Karate", "Judo", "Taekwondo"],
            amenities: ["Changing Rooms", "Seating", "Restrooms"],
            images: ["sample3", "sample2"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5515, longitude: 73.9030)
        ),
        Venue(
            name: "Sunset Volleyball Beach",
            description: "Sandy beach court with nets for volleyball and beach soccer, perfect for group fun and tournaments.",
            rating: 4.1,
            distance: 8.2,
            hourlyRate: 400,
            reviewCount: 38,
            address: "Beachside Road, Hinjewadi, Pune",
            hours: "6:00 AM - 8:00 PM (Mon - Sun)",
            sports: ["Volleyball", "Beach Soccer"],
            amenities: ["Parking", "Water", "Restrooms", "Seating"],
            images: ["sample4", "sample2"],
            locationCoordinate: CLLocationCoordinate2D(latitude: 18.5970, longitude: 73.7000)
        )
    ]
}
