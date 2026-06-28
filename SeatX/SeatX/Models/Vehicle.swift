import Foundation

enum VehicleType {
    case electric
    case combustion
    case hybrid
}

protocol Vehicle: Identifiable {
    var id: UUID { get }
    var make: String { get }
    var model: String { get }
    var year: Int { get }
    var type: VehicleType { get }
}

struct EVVehicle: Vehicle {
    let id: UUID
    let make: String
    let model: String
    let year: Int
    let type: VehicleType = .electric
    
    var stateOfCharge: Double // 0.0 to 1.0
    var isCharging: Bool
    var rangeEstimate: Measurement<UnitLength>
}

struct ICEVehicle: Vehicle {
    let id: UUID
    let make: String
    let model: String
    let year: Int
    var type: VehicleType // Could be .combustion or .hybrid
    
    var fuelLevel: Double // 0.0 to 1.0
    var distanceToEmpty: Measurement<UnitLength>
}
