import SwiftUI

struct ContentView: View {
    @State private var selectedTab : Int? = 0

    var body: some View {
        #if os(macOS)
        NavigationSplitView {
            Sidebar(selectedTab: $selectedTab)
                .frame(minWidth: 200, maxWidth: 300)
        } detail: {
            Group {
                if selectedTab == 0 {
                    ChatView()
                } else {
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        #else
        TabView(selection: $selectedTab) {
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }
                .tag(0)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(1)
        }
        #endif
    }
}
