# LMStudio Chat App

LMStudio is a SwiftUI-based chat application that allows users to create, manage, and participate in chat sessions. The app supports multiple chat threads and persists chat messages using a local storage mechanism.

## Features
- **Multi-chat support**: Users can create and switch between multiple chat sessions.
- **Local chat history**: Messages are saved and loaded automatically.
- **Cross-platform UI**: Supports macOS and iOS with adaptive navigation views.
- **Modern SwiftUI design**: Uses SwiftUI components like `NavigationSplitView`, `TabView`, and `Picker`.

## Requirements
- macOS 12+ or iOS 15+
- Xcode 14+
- Swift 5+

## Installation and Setup
### Clone the Repository
```sh
 git clone <repository-url>
 cd LMStudio
```

### Open in Xcode
1. Launch **Xcode**.
2. Select **File > Open** and navigate to the `LMStudio` folder.
3. Open the project and wait for dependencies to resolve.

### Build and Run
1. Select the target device (iPhone, iPad, or Mac).
2. Click **Run** (`⌘R`).

## Project Structure
- **LMStudioApp.swift**: The main entry point of the app.
- **ContentView.swift**: Handles navigation between chat and settings.
- **ChatView.swift**: Displays chat messages and allows users to create/select conversations.
- **ChatLogManager.swift**: Manages storage and retrieval of chat messages.
- **SettingsView.swift**: Contains user-configurable settings.

## Settings Explained

The Settings section in LMStudio allows you to configure the following:
- API Settings
- API URL: Specify the endpoint that the app will use to connect with the backend server. By default, it is set to https://10.0.0.10:1234.
- Model Settings
- Model Picker: Choose from a list of available models that the app can use. This list is loaded dynamically by pressing the refresh button (🔄).
- Temperature: Adjust the creativity of the model’s responses. The value ranges from 0.0 (more deterministic) to 2.0 (more creative), with a default of 0.8.
- Max Tokens: Set the maximum number of tokens (words or word pieces) the model can generate in a response. The slider allows you to choose a value between 32 and 8192, with a default value of 512.

These settings let you customize the behavior of the chat AI, from its connection endpoint to the style and length of generated responses.

## Contributing
Pull requests are welcome! Please ensure that your changes align with the SwiftUI design principles.

## License
This project is licensed under [Your License Here].



I’ve added a new section in the README that explains the settings in detail. Here is the updated version:

LMStudio Chat App

LMStudio is a SwiftUI-based chat application that allows users to create, manage, and participate in chat sessions. The app supports multiple chat threads and persists chat messages using a local storage mechanism.

Features
    •    Multi-chat support: Users can create and switch between multiple chat sessions.
    •    Local chat history: Messages are saved and loaded automatically.
    •    Cross-platform UI: Supports macOS and iOS with adaptive navigation views.
    •    Modern SwiftUI design: Uses SwiftUI components like NavigationSplitView, TabView, and Picker.

Requirements
    •    macOS 12+ or iOS 15+
    •    Xcode 14+
    •    Swift 5+

Installation and Setup

Clone the Repository

git clone <repository-url>
cd LMStudio

Open in Xcode
    1.    Launch Xcode.
    2.    Select File > Open and navigate to the LMStudio folder.
    3.    Open the project and wait for dependencies to resolve.

Build and Run
    1.    Select the target device (iPhone, iPad, or Mac).
    2.    Click Run (⌘R).

Project Structure
    •    LMStudioApp.swift: The main entry point of the app.
    •    ContentView.swift: Handles navigation between chat and settings.
    •    ChatView.swift: Displays chat messages and allows users to create/select conversations.
    •    ChatLogManager.swift: Manages storage and retrieval of chat messages.
    •    SettingsView.swift: Contains user-configurable settings for the app.


Contributing

Pull requests are welcome! Please ensure that your changes align with SwiftUI design principles.

License

This project is licensed under [Your License Here].

Let me know if you’d like any further tweaks or additional sections! What do you think? 😎🚀 ￼
