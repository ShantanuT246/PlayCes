import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    let colors: [Color] = [.cyan.opacity(0.6), .indigo.opacity(0.9), .mint.opacity(0.6), .brown.opacity(0.6)] // Selected tab colors
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomePage()
            }
            .tabItem {
                Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
            }
            .tag(0)
            
            NavigationStack {
                MyTeamsPage()
            }
            .tabItem {
                Label("Teams", systemImage: selectedTab == 1 ? "person.3" : "person.3.fill")
            }
            .tag(1)
            
            NavigationStack {
                MyBookingsPage()
            }
            .tabItem {
                Label("Bookings", systemImage: selectedTab == 2 ? "ticket.fill" : "ticket")
            }
            .tag(2)
            
            NavigationStack {
                SettingsPage()
            }
            .tabItem {
                Label("Settings", systemImage: selectedTab == 3 ? "gear" : "gear")
            }
            .tag(3)
        }
        .accentColor(colors[selectedTab])
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
