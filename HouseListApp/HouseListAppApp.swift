import SwiftUI

@main
struct HouseListAppApp: App {
    @StateObject private var viewModel = ItemsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
