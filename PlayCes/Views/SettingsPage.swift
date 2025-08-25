import SwiftUI

// MARK: - Settings Models
struct SettingSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [SettingItem]
}

struct SettingItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let icon: String
    let iconColor: Color
    let type: SettingItemType
}

enum SettingItemType {
    case toggle(Binding<Bool>)
    case navigation(() -> AnyView)
    case action(() -> Void)
    case value(String)
}

// MARK: - Main Settings View
struct SettingsPage: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("emailUpdatesEnabled") private var emailUpdatesEnabled = false
    @AppStorage("distanceUnit") private var distanceUnit = 0
    @AppStorage("appLanguage") private var appLanguage = 0
    
    @State private var showingEditProfile = false
    @State private var showingPrivacyPolicy = false
    @State private var showingTermsOfService = false
    @State private var showingDeleteConfirmation = false
    @State private var showingLogoutConfirmation = false
    
    private let settingsSections: [SettingSection] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.brown.opacity(0.35), Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(edges: .top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header section
                        VStack(spacing: 16) {
                            // Top bar with title
                            HStack {
                                Text("Settings")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Button(action: {}) {
                                    Image(systemName: "questionmark.circle")
                                        .font(.title2)
                                        .foregroundStyle(.white)
                                        .padding(8)
                                        .background(.ultraThinMaterial.opacity(0.7))
                                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                }
                            }
                            
                            // Welcome message
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Customize your experience")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                Text("Manage your preferences and account settings")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.9))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .padding(.top, 0)
                        
                        // Settings sections
                        VStack(spacing: 24) {
                            // Account settings
                            SettingsSectionView(
                                title: "Account",
                                items: [
                                    SettingItem(
                                        title: "Edit Profile",
                                        subtitle: "Update your personal information",
                                        icon: "person",
                                        iconColor: .blue,
                                        type: .navigation { AnyView(ProfilePage()) }
                                    ),
                                    SettingItem(
                                        title: "Payment Methods",
                                        subtitle: "Manage your payment options",
                                        icon: "creditcard",
                                        iconColor: .green,
                                        type: .navigation { AnyView(Text("Payment Methods")) }
                                    ),
                                    SettingItem(
                                        title: "Booking History",
                                        subtitle: "View your past bookings",
                                        icon: "clock",
                                        iconColor: .orange,
                                        type: .navigation { AnyView(Text("Booking History")) }
                                    )
                                ]
                            )
                            
                            // Preferences
                            SettingsSectionView(
                                title: "Preferences",
                                items: [
                                    SettingItem(
                                        title: "Appearance",
                                        subtitle: isDarkMode ? "Dark Mode" : "Light Mode",
                                        icon: "moon",
                                        iconColor: .purple,
                                        type: .toggle($isDarkMode)
                                    ),
                                    SettingItem(
                                        title: "Notifications",
                                        subtitle: "Manage alerts",
                                        icon: "bell",
                                        iconColor: .red,
                                        type: .toggle($notificationsEnabled)
                                    ),
                                    SettingItem(
                                        title: "Email Updates",
                                        subtitle: "Receive news and offers",
                                        icon: "envelope",
                                        iconColor: .blue,
                                        type: .toggle($emailUpdatesEnabled)
                                    ),
                                    SettingItem(
                                        title: "Distance Unit",
                                        subtitle: distanceUnit == 0 ? "Kilometers" : "Miles",
                                        icon: "ruler",
                                        iconColor: .green,
                                        type: .navigation { AnyView(DistanceUnitSettings()) }
                                    ),
                                    SettingItem(
                                        title: "Language",
                                        subtitle: appLanguage == 0 ? "English" : "Spanish",
                                        icon: "globe",
                                        iconColor: .orange,
                                        type: .navigation { AnyView(LanguageSettings()) }
                                    )
                                ]
                            )
                            
                            // Support
                            SettingsSectionView(
                                title: "Support",
                                items: [
                                    SettingItem(
                                        title: "Help Center",
                                        subtitle: "Get help with common issues",
                                        icon: "questionmark.circle",
                                        iconColor: .blue,
                                        type: .navigation { AnyView(Text("Help Center")) }
                                    ),
                                    SettingItem(
                                        title: "Contact Us",
                                        subtitle: "Reach out to our support team",
                                        icon: "message",
                                        iconColor: .green,
                                        type: .navigation { AnyView(Text("Contact Us")) }
                                    ),
                                    SettingItem(
                                        title: "About PlayCes",
                                        subtitle: "App version 1.0.0",
                                        icon: "info.circle",
                                        iconColor: .purple,
                                        type: .navigation { AnyView(Text("About PlayCes")) }
                                    )
                                ]
                            )
                            
                            // Legal
                            SettingsSectionView(
                                title: "Legal",
                                items: [
                                    SettingItem(
                                        title: "Privacy Policy",
                                        subtitle: "How we handle your data",
                                        icon: "lock",
                                        iconColor: .blue,
                                        type: .action { showingPrivacyPolicy = true }
                                    ),
                                    SettingItem(
                                        title: "Terms of Service",
                                        subtitle: "App usage terms and conditions",
                                        icon: "doc.text",
                                        iconColor: .gray,
                                        type: .action { showingTermsOfService = true }
                                    )
                                ]
                            )
                            
                            // Account actions
                            VStack(spacing: 16) {
                                Button(action: { showingLogoutConfirmation = true }) {
                                    Text("Log Out")
                                        .font(.headline)
                                        .foregroundColor(.red)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(.systemBackground))
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.red.opacity(0.3), lineWidth: 1)
                                        )
                                }
                                
                                Button(action: { showingDeleteConfirmation = true }) {
                                    Text("Delete Account")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingPrivacyPolicy) {
                // In a real app, this would be your PrivacyPolicyView
                Text("Privacy Policy")
                    .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $showingTermsOfService) {
                // In a real app, this would be your TermsOfServiceView
                Text("Terms of Service")
                    .presentationDetents([.medium, .large])
            }
            .confirmationDialog("Log Out", isPresented: $showingLogoutConfirmation) {
                Button("Log Out", role: .destructive) {
                    // Handle logout
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to log out?")
            }
            .confirmationDialog("Delete Account", isPresented: $showingDeleteConfirmation) {
                Button("Delete Account", role: .destructive) {
                    // Handle account deletion
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This action cannot be undone. All your data will be permanently deleted.")
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

// MARK: - Settings Section View
struct SettingsSectionView: View {
    let title: String
    let items: [SettingItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .padding(.bottom, 8)
            
            VStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    SettingRowView(item: item)
                    
                    if index < items.count - 1 {
                        Divider()
                            .padding(.leading, 52)
                    }
                }
            }
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
            .padding(.horizontal)
        }
    }
}

// MARK: - Setting Row View
struct SettingRowView: View {
    let item: SettingItem
    
    var body: some View {
        Group {
            switch item.type {
            case .navigation(let destination):
                NavigationLink(destination: destination()) {
                    rowContent
                }
            default:
                rowContent
                    .onTapGesture {
                        if case .action(let action) = item.type {
                            action()
                        }
                    }
            }
        }
    }
    
    private var rowContent: some View {
        HStack {
            // Icon
            Image(systemName: item.icon)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(item.iconColor)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.body)
                    .foregroundColor(.primary)
                
                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            switch item.type {
            case .toggle(let binding):
                Toggle("", isOn: binding)
                    .labelsHidden()
            case .navigation:
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            case .action:
                EmptyView()
            case .value(let value):
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - Sub-settings Views
struct DistanceUnitSettings: View {
    @AppStorage("distanceUnit") private var distanceUnit = 0
    
    var body: some View {
        Form {
            Section("Distance Unit") {
                Picker("Unit", selection: $distanceUnit) {
                    Text("Kilometers").tag(0)
                    Text("Miles").tag(1)
                }
                .pickerStyle(.segmented)
                
                Text("This setting affects how distances are displayed throughout the app.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Distance Unit")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LanguageSettings: View {
    @AppStorage("appLanguage") private var appLanguage = 0
    
    var body: some View {
        Form {
            Section("App Language") {
                Picker("Language", selection: $appLanguage) {
                    Text("English").tag(0)
                    Text("Spanish").tag(1)
                    Text("French").tag(2)
                    Text("German").tag(3)
                }
                
                Text("Changing the language will require the app to restart.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Language")
        .navigationBarTitleDisplayMode(.inline)
    }
}

