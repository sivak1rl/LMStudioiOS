import SwiftUI

struct SettingsView: View {
    @AppStorage("apiURL") var apiURL: String = "https://10.0.0.10:1234"
    @AppStorage("selectedModel") var selectedModel: String = ""
    @AppStorage("temperature") var temperature: Double = 0.8
    @AppStorage("maxTokens") var maxTokens: Int = 512

    @State private var availableModels: [String] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        Form {
            Section(header: Text("API Settings")) {
                TextField("API URL", text: $apiURL)
                    #if os(iOS)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                    #endif
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Section(header: HStack {
                Text("Model Settings")
                Spacer()
                Button(action: loadModels) {
                    Image(systemName: "arrow.clockwise")
                }
            }) {
                if isLoading {
                    ProgressView("Loading models...")
                } else if let errorMessage = errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                }

                Picker("Model", selection: $selectedModel) {
                    ForEach(availableModels, id: \.self) { model in
                        Text(model).tag(model)
                    }
                }

                VStack {
                    Slider(value: $temperature, in: 0.0...2.0, step: 0.05)
                        Text("Temperature: \(temperature, specifier: "%.2f")")
                }

                VStack {
                    Slider(value: Binding<Double>(
                        get: { Double(maxTokens) },
                        set: { maxTokens = Int($0) }
                    ), in: 32...8192, step: 32)
                        Text("Max Tokens: \(maxTokens)")
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear(perform: loadModels)
        #if os(iOS)
        .gesture(
            TapGesture()
                .onEnded { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        )
        #endif
    }

    func loadModels() {
        guard let url = URL(string: apiURL.trimmingCharacters(in: .whitespacesAndNewlines) + "/v1/models") else {
            errorMessage = "Invalid API URL"
            return
        }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = "Error fetching models: $error.localizedDescription)"
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self.errorMessage = "Invalid response from API"
                    return
                }

                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let modelsData = json["data"] as? [[String: Any]] else {
                    self.errorMessage = "Malformed data from API"
                    return
                }

                self.availableModels = modelsData.compactMap { $0["id"] as? String }

                if !self.availableModels.contains(self.selectedModel), let firstModel = self.availableModels.first {
                    self.selectedModel = firstModel
                }
            }
        }.resume()
    }
}
