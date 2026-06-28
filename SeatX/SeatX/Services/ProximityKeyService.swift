import Foundation
import CoreBluetooth

enum ProximityKeyState {
    case locked
    case unlocked
    case unknown
}

protocol ProximityKeyClient {
    var connectionState: ProximityKeyState { get }
    func unlock() async throws
    func lock() async throws
}

class SeatXProximityClient: NSObject, ProximityKeyClient {
    private(set) var connectionState: ProximityKeyState = .unknown
    
    func unlock() async throws {
        print("Bluetooth: Sending unlock command to SeatX vehicle...")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        connectionState = .unlocked
    }
    
    func lock() async throws {
        print("Bluetooth: Sending lock command to SeatX vehicle...")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        connectionState = .locked
    }
}
