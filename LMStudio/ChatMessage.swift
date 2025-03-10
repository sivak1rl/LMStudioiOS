//
//  ChatMessage.swift
//  LMStudio
//
//  Created by Rich Sivak on 3/10/25.
//
import SwiftUI


// MARK: - Models

struct ChatMessage: Identifiable, Codable {
    var id = UUID()
    var role: String   // "user" or "ai"
    var content: String
}
