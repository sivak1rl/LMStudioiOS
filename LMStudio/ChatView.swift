import SwiftUI

struct ChatView: View {
    @State private var messages: [ChatMessage] = []
    @State private var inputText: String = ""
    @State private var isLoading: Bool = false
    @State private var selectedChatID: String = "default"
    @State private var chatList: [String] = []
    @State private var newChatName: String = ""
    @State private var editingMessage: ChatMessage? = nil

    var body: some View {
        return VStack(spacing: 10) {
            HStack {
                TextField("New chat name", text: $newChatName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minWidth: 150)
                Button("Create Chat") {
                    guard !newChatName.isEmpty else { return }
                    ChatLogManager.shared.createChat(named: newChatName)
                    chatList = ChatLogManager.shared.listChats()
                    selectedChatID = newChatName
                    messages = []
                    newChatName = ""
                }
            }
            .padding()
            
            Picker("Select Chat", selection: $selectedChatID) {
                ForEach(chatList, id: \ .self) { chat in
                    Text(chat).tag(chat)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedChatID) { _, _ in  // Fixed for iOS 17
                            messages = ChatLogManager.shared.loadMessages(for: selectedChatID)
            }
            .onAppear {
                chatList = ChatLogManager.shared.listChats()
                if chatList.isEmpty { chatList.append("default") }
                selectedChatID = chatList.first ?? "default"
                messages = ChatLogManager.shared.loadMessages(for: selectedChatID)
            }
            
            ScrollViewReader { scrollProxy in
                            ScrollView {
                                ForEach(messages) { message in
                                    HStack {
                                        MessageRow(message: message)
                                            .id(message.id)
                                        
                                        
                                        Button("🗑️") {
                                            deleteMessage(message)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                }
                            }
                        }
            
            HStack {
                TextField("Type a message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)
                
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding()
            
            Button("Delete Chat") {
                ChatLogManager.shared.deleteChat(named: selectedChatID)
                chatList = ChatLogManager.shared.listChats()
                selectedChatID = chatList.first ?? "default"
                messages = ChatLogManager.shared.loadMessages(for: selectedChatID)
            }
            .foregroundColor(.red)
            .padding()
        }
        
        func sendMessage() {
            guard !inputText.isEmpty else { return }
            let newMessage = ChatMessage(role: "user", content: inputText)
            messages.append(newMessage)
            inputText = ""
            
            ChatLogManager.shared.saveMessages(messages, for: selectedChatID) // Save updated chat history
            Task {
                await sendToAPI()
            }
        }
        
        func deleteMessage(_ message: ChatMessage) {
            ChatLogManager.shared.deleteMessage(in: selectedChatID, messageID: message.id)
            messages = ChatLogManager.shared.loadMessages(for: selectedChatID)
        }

        
        func sendToAPI() async {
            isLoading = true
            defer { isLoading = false }
            @AppStorage("apiURL") var baseAPIURL: String = "https://10.0.0.10:1234"
            @AppStorage("selectedModel") var selectedModel: String = "phi-4"
            @AppStorage("temperature") var temperature: Double = 0.8
            @AppStorage("maxTokens") var maxTokens: Int = 512
            
            
            // Ensure the base API URL does not have a trailing slash before appending the endpoint
            let apiURL = baseAPIURL.trimmingCharacters(in: CharacterSet(charactersIn: "/")) + "/v1/chat/completions"
            
            guard let url = URL(string: apiURL) else {
                print("Invalid API URL: \(apiURL)")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Build payload with the conversation history
            let payload: [String: Any] = [
                "model": selectedModel,
                "messages": messages.map { ["role": $0.role, "content": $0.content] },
                "temperature": temperature,
                "max_tokens": maxTokens
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Expecting a response structure: { "choices": [ { "message": { "content": "AI response" } } ] }
                if let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = responseDict["choices"] as? [[String: Any]],
                   let firstChoice = choices.first,
                   let message = firstChoice["message"] as? [String: Any],
                   let aiText = message["content"] as? String {
                    
                    let aiMessage = ChatMessage(role: "assistant", content: aiText)
                    DispatchQueue.main.async {
                        messages.append(aiMessage)
                        ChatLogManager.shared.saveMessages(messages, for: selectedChatID)
                    }

                }
            } catch {
                print("API Error: \(error)")
            }
        }
        
    }
}
