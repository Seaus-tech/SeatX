import Foundation

protocol AutomotiveDataProvider {
    func fetchVehicles() async throws -> [any Vehicle]
    func refreshStatus(for vehicleID: UUID) async throws -> any Vehicle
}

class MockAutomotiveService: AutomotiveDataProvider {
    func fetchVehicles() async throws -> [any Vehicle] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return [
            EVVehicle(
                id: UUID(),
                make: "Tesla",
                model: "Model S",
                year: 2025,
                stateOfCharge: 0.82,
                isCharging: false,
                rangeEstimate: Measurement(value: 320, unit: .miles)
            ),
            ICEVehicle(
                id: UUID(),
                make: "Audi",
                model: "RS6 Avant",
                year: 2026,
                type: .combustion,
                fuelLevel: 0.45,
                distanceToEmpty: Measurement(value: 210, unit: .miles)
            ),
            EVVehicle(
                id: UUID(),
                make: "SeatX",
                model: "Nebula",
                year: 2027,
                stateOfCharge: 0.95,
                isCharging: true,
                rangeEstimate: Measurement(value: 410, unit: .miles)
            )
        ]
    }
    
    func refreshStatus(for vehicleID: UUID) async throws -> any Vehicle {
        \/\/ Simulate network delay
        try await Task.sleep(nanoseconds: 300_000_000)
        
        let vehicles = try await fetchVehicles()
        if let vehicle = vehicles.first(where: { $0.id == vehicleID }) {
            return vehicle
        }
        
        throw NSError(domain: "AutomotiveService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Vehicle not found"])
    }
}
