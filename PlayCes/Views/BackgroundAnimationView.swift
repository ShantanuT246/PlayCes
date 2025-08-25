//
//  FallingIcon.swift
//  PlayCes
//
//  Created by Shantanu Tapole on 20/08/25.
//
import SwiftUI


struct FallingIcon: Identifiable {
    let id = UUID()
    let name: String   // asset name
    let x: CGFloat
    var y: CGFloat
    let speed: Double
    let delay: Double
}

//MARK: - Background Falling Icons
struct FallingIconView: View {
    let icons: [String]   // names of images in assets
    @State private var items: [FallingIcon] = []

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(items) { item in
                    Image(item.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .opacity(0.8)
                        .position(x: item.x, y: item.y)
                        .onAppear {
                            // Start the continuous fall animation
                            fall(item: item, geoHeight: geo.size.height)
                        }
                }
            }
            .onAppear {
                let count = 10
                items = (0..<count).map { _ in
                    FallingIcon(
                        name: icons.randomElement() ?? "icons8-basketball-100",
                        x: CGFloat.random(in: 0...geo.size.width),
                        y: -40,
                        speed: Double.random(in: Double(geo.size.height) / 150 ... Double(geo.size.height) / 60),
                        delay: Double.random(in: 0...3)
                    )
                }
            }
        }
        .ignoresSafeArea()
    }

    private func fall(item: FallingIcon, geoHeight: CGFloat) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        withAnimation(
            Animation.linear(duration: item.speed)
                .delay(item.delay)
        ) {
            items[index].y = geoHeight + 40 // move beyond bottom
        }
        // Reset after animation finishes
        DispatchQueue.main.asyncAfter(deadline: .now() + item.speed + item.delay) {
            items[index].y = -40 // reset to top
            fall(item: items[index], geoHeight: geoHeight) // repeat
        }
    }
}
