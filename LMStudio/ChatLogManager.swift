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

    func getChatFile(for chatID: String) -> URL {
        return logsDirectory.appendingPathComponent("\(chatID).json")
    }

    func saveMessages(_ messages: [ChatMessage], for chatID: String) {
        do {
            let data = try JSONEncoder().encode(messages)
            try data.write(to: getChatFile(for: chatID))
        } catch {
            print("Failed to save chat history: \(error.localizedDescription)")
        }
    }

    func deleteMessage(in chatID: String, messageID: UUID) {
        var messages = loadMessages(for: chatID)
        messages.removeAll { $0.id == messageID }
        saveMessages(messages, for: chatID)
    }
    
    func loadMessages(for chatID: String) -> [ChatMessage] {
        let chatFile = getChatFile(for: chatID)
        guard fileManager.fileExists(atPath: chatFile.path) else { return [] }
        
        do {
            let data = try Data(contentsOf: chatFile)
            return try JSONDecoder().decode([ChatMessage].self, from: data)
        } catch {
            print("Failed to load chat history: \(error.localizedDescription)")
            return []
        }
    }

    func listChats() -> [String] {
        do {
            let files = try fileManager.contentsOfDirectory(at: logsDirectory, includingPropertiesForKeys: nil)
            return files.map { $0.deletingPathExtension().lastPathComponent }
        } catch {
            print("Failed to list chat sessions: \(error.localizedDescription)")
            return []
        }
    }

    func createChat(named name: String) {
        let newChatFile = getChatFile(for: name)
        if !fileManager.fileExists(atPath: newChatFile.path) {
            saveMessages([], for: name) // Create an empty chat file
        }
    }

    func deleteChat(named name: String) {
        let chatFile = getChatFile(for: name)
        do {
            try fileManager.removeItem(at: chatFile)
        } catch {
            print("Failed to delete chat: \(error.localizedDescription)")
        }
    }
}
