//
//  Sidebar.swift
//  LMStudio
//
//  Created by Rich Sivak on 3/10/25.
//
import SwiftUI

struct Sidebar: View {
    @Binding var selectedTab: Int?

    var body: some View {
        List {
            NavigationLink(destination: ChatView(), tag: 0, selection: $selectedTab) {
                Label("Chat", systemImage: "message.fill")
            }
            
            NavigationLink(destination: SettingsView(), tag: 1, selection: $selectedTab) {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
        .navigationTitle("Sidebar")
    }
}
