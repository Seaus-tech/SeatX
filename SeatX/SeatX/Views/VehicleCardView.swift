import SwiftUI

struct VehicleCardView: View {
    let vehicle: any Vehicle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(vehicle.year) \(vehicle.make)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(vehicle.model)
                        .font(.title2.bold())
                }
                Spacer()
                Image(systemName: vehicle.type == .electric ? "bolt.car.fill" : "fuelpump.fill")
                    .font(.title)
                    .foregroundStyle(.blue)
            }
            
            Spacer()
            
            adaptiveMetricsView
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(uiColor: .secondarySystemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
    
    @ViewBuilder
    private var adaptiveMetricsView: some View {
        if let ev = vehicle as? EVVehicle {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(Int(ev.stateOfCharge * 100))%")
                        .font(.largeTitle.bold())
                    if ev.isCharging {
                        Image(systemName: "bolt.fill")
                            .foregroundStyle(.green)
                    }
                }
                Text("\(ev.rangeEstimate.value.formatted()) \(ev.rangeEstimate.unit.symbol) remaining")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        } else if let ice = vehicle as? ICEVehicle {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(Int(ice.fuelLevel * 100))%")
                    .font(.largeTitle.bold())
                Text("\(ice.distanceToEmpty.value.formatted()) \(ice.distanceToEmpty.unit.symbol) to empty")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    VehicleCardView(vehicle: EVVehicle(
        id: UUID(),
        make: "Tesla",
        model: "Model S",
        year: 2025,
        stateOfCharge: 0.82,
        isCharging: true,
        rangeEstimate: Measurement(value: 320, unit: .miles)
    ))
    .padding()
}
