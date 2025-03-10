import SwiftUI

struct ChatView: View {
    @State private var messages: [ChatMessage] = []
    @State private var inputText: String = ""
    @State private var isLoading: Bool = false

    @State private var newMessage: String = ""

    var body: some View {
        VStack(spacing: 10) {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    ForEach(messages) { message in
                        MessageRow(message: message)
                            .id(message.id)
                    }
                }
                .onChange(of: messages.count) {
                    if let lastID = messages.last?.id {
                        withAnimation {
                            scrollProxy.scrollTo(lastID, anchor: .bottom)
                        }
                    }
                }
            }

            HStack {
                    TextField("Type a message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
    }

    func sendMessage() {
        guard !inputText.isEmpty else { return }
        let userMessage = ChatMessage(role: "user", content: inputText)
        messages.append(userMessage)
        inputText = ""
        Task {
            await sendToAPI()
        }
    }
        func sendToAPI() async {
        isLoading = true
        defer { isLoading = false }
        @AppStorage("apiURL") var baseAPIURL: String = "https://10.0.0.10:1234"
        @AppStorage("selectedModel") var selectedModel: String = "phi-4"
        @AppStorage("temperature") var temperature: Double = 0.8
        @AppStorage("maxTokens") var maxTokens: Int = 512

        // Retrieve API settings from @AppStorage
        // let baseAPIURL = UserDefaults.standard.string(forKey: "apiURL") ?? "http://10.0.0.10:1234"
        // let selectedModel = UserDefaults.standard.string(forKey: "selectedModel") ?? "phi4"
        // let temperature = UserDefaults.standard.double(forKey: "temperature")
        // let maxTokens = UserDefaults.standard.integer(forKey: "maxTokens")
        
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
                }
            }
        } catch {
            print("API Error: \(error)")
        }
    }

}
