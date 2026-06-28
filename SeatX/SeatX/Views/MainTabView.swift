import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            GarageView()
                .tabItem {
                    Label("Garage", systemImage: "car.2.fill")
                }
            
            Text("Maps View")
                .tabItem {
                    Label("Maps", systemImage: "map.fill")
                }
            
            Text("Community")
                .tabItem {
                    Label("Community", systemImage: "person.3.fill")
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
