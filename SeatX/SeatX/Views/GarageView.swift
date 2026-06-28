import SwiftUI

struct GarageView: View {
    @State private var vehicles: [any Vehicle] = []
    @State private var isLoading = true
    
    let service: AutomotiveDataProvider = MockAutomotiveService()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    Text("My Garage")
                        .font(.largeTitle.bold())
                        .padding(.horizontal)
                    
                    if isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(vehicles, id: \.id) { vehicle in
                                    VehicleCardView(vehicle: vehicle)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        quickActionsSection
                    }
                }
                .padding(.vertical)
            }
            .task {
                do {
                    vehicles = try await service.fetchVehicles()
                    isLoading = false
                } catch {
                    print("Error fetching vehicles: \(error)")
                }
            }
        }
    }
    
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Quick Actions")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ActionButton(title: "Climate", icon: "thermometer.medium")
                    ActionButton(title: "Unlock", icon: "lock.open.fill")
                    ActionButton(title: "Charge", icon: "bolt.fill")
                    ActionButton(title: "Location", icon: "location.fill")
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
            Text(title)
                .font(.caption.bold())
        }
        .frame(width: 80, height: 80)
        .background(Circle().fill(Color.blue.opacity(0.1)))
        .foregroundStyle(.blue)
    }
}

#Preview {
    GarageView()
}
