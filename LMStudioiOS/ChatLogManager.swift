//
//  ChatLogManager.swift
//  LMStudioiOS
//
//  Created by Rich Sivak on 3/10/25.
//
import SwiftUI

// MARK: - Chat Log Manager

class ChatLogManager {
    static let shared = ChatLogManager()
    private let fileManager = FileManager.default
    private let logsDirectory: URL

    init() {
        let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        logsDirectory = docs.appendingPathComponent("ChatLogs")
        if !fileManager.fileExists(atPath: logsDirectory.path) {
            try? fileManager.createDirectory(at: logsDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }

    func getChatLogs() -> [URL] {
        (try? fileManager.contentsOfDirectory(at: logsDirectory, includingPropertiesForKeys: nil, options: [])) ?? []
    }

    func saveChatLog(chatName: String, messages: [ChatMessage]) {
        let fileURL = logsDirectory.appendingPathComponent("\(chatName).json")
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(messages) {
            try? data.write(to: fileURL)
        }
    }

    func loadChatLog(chatName: String) -> [ChatMessage]? {
        let fileURL = logsDirectory.appendingPathComponent("\(chatName).json")
        let decoder = JSONDecoder()
        if let data = try? Data(contentsOf: fileURL) {
            return try? decoder.decode([ChatMessage].self, from: data)
        }
        return nil
    }

    func deleteChatLog(chatName: String) {
        let fileURL = logsDirectory.appendingPathComponent("\(chatName).json")
        try? fileManager.removeItem(at: fileURL)
    }
}
