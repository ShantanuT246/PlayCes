//
//  BookingCard.swift
//  PlayCes
//
//  Created by Shantanu Tapole on 22/08/25.
//
import SwiftUI

// MARK: - Booking Card View
struct BookingCard: View {
    let booking: Booking
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d • h:mm a"
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: booking.imageName)
                    .font(.system(size: 20))
                    .foregroundColor(booking.status.color)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(booking.venueName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(booking.sport)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Capsule()
                    .fill(booking.status.color.opacity(0.2))
                    .frame(width: 90, height: 26)
                    .overlay(
                        Text(booking.status.title)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(booking.status.color)
                    )
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Label(dateFormatter.string(from: booking.date), systemImage: "calendar")
                    Label(booking.duration, systemImage: "clock")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("₹\(Int(booking.price))")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("\(booking.participants) participants")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            if booking.status == .upcoming {
                HStack(spacing: 12) {
                    Button(action: {}) {
                        Text("Cancel")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {}) {
                        Text("Reschedule")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            } else if booking.status == .completed {
                Button(action: {}) {
                    Text("Book Again")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(booking.status.color.opacity(0.3), lineWidth: 1)
        )
    }
}


// MARK: - Empty State View
struct EmptyBookingsView: View {
    let status: Int
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: status == 0 ? "calendar.badge.exclamationmark" : "clock.badge.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            Text(status == 0 ? "No Upcoming Bookings" : "No Previous Bookings")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(status == 0 ? "You don't have any upcoming bookings. Book a venue to get started!" : "Your previous bookings will appear here once you complete some games.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if status == 0 {
                NavigationLink(destination: HomePage()) {
                    Text("Browse Venues")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding(40)
    }
}
