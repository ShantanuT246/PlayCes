import SwiftUI

struct VenueCard: View {
    let venue: Venue
    @State private var isFavorited: Bool = false

    
    var body: some View {
        NavigationLink(destination: VenueDetailView(venue: venue)) {
            VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                if let firstImage = venue.images.first {
                    Image(firstImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 160)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .foregroundColor(.cyan.opacity(0.7))
                }
                
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
                .padding(12)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(venue.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("₹\(Int(venue.hourlyRate))/hr")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.cyan)
                }
                
                Text(venue.sports.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.orange)
                    
                    Text(String(format: "%.1f", venue.rating))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("•")
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "location")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                    Text(String(format: "%.1f km", venue.distance))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button("Book Now") {}
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)

                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.blue.opacity(0.6))
                        .clipShape(Capsule())
                }
            }
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
