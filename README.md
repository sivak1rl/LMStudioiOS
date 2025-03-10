# LMStudioiOS

LMStudioiOS is an iOS application designed to facilitate seamless interaction with and configuration of **LM Studio**. This app offers a user-friendly interface for chatting with LM Studio and customizing its settings to suit your preferences.

> *"An iOS app to chat with and configure settings for LM Studio."*  
> citeturn0search0

## Features

- **Chat Interface:** Engage in real-time conversations with LM Studio.
- **Configuration Panel:** Easily adjust and personalize your studio settings.
- **Swift-Powered:** Built entirely using Swift for optimal performance and integration.
- **Cross-Platform Potential:** Explore building the app for macOS using Mac Catalyst.

## Requirements

- **macOS Version:** macOS 11.0 (Big Sur) or later
- **Xcode:** Version 12 or later
- **iOS Deployment Target:** iOS 14.0 or later

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/sivak1rl/LMStudioiOS.git
   ```


2. **Open the Project in Xcode:**

   ```bash
   cd LMStudioiOS
   open LMStudioiOS.xcodeproj
   ```


## Building and Running the Application

### On iOS Simulator

1. **Select the Target Device:**

   In Xcode's toolbar, click on the device selector and choose an iOS simulator (e.g., iPhone 13).

2. **Build and Run:**

   - Press the **Run** button (▶️) in the toolbar or choose **Product > Run** from the menu.
   - Xcode will build the project and launch it in the selected simulator.

### On a Physical iOS Device

1. **Connect Your Device:**

   Plug your iOS device into your Mac using a USB cable.

2. **Trust the Device:**

   - On your iOS device, a prompt will appear asking you to trust the connected computer. Tap **Trust** and enter your device passcode if prompted.

3. **Select Your Device in Xcode:**

   - In Xcode, click on the device selector and choose your connected iOS device.

4. **Enable Developer Mode on Your Device (iOS 16 and Later):**

   - On your iOS device, navigate to **Settings > Privacy & Security**.
   - Scroll down and enable **Developer Mode**.
   - Restart your device if prompted.

5. **Provisioning Profile:**

   - Xcode should automatically manage the provisioning profile using your Apple ID.
   - If prompted, sign in with your Apple ID in Xcode's preferences under the **Accounts** tab.

6. **Build and Run:**

   - Press the **Run** button (▶️) in the toolbar or choose **Product > Run** from the menu.
   - Xcode will build the project and install it on your connected device.

   *Note: A paid Apple Developer account is not required to run the app on your own device; however, the app will be valid for a limited time (usually 7 days) without a paid account.* citeturn0search7

### Building for macOS Using Mac Catalyst

With Mac Catalyst, you can run your iPad app on macOS with minimal changes.

1. **Enable Mac Catalyst:**

   - In Xcode, select the **LMStudioiOS** project in the Project Navigator.
   - Select the **LMStudioiOS** target.
   - Navigate to the **General** tab.
   - Check the box labeled **Mac** under the **Deployment Info** section.

2. **Configure macOS-Specific Settings:**

   - Adjust any macOS-specific settings or features as needed.
   - Ensure that the app's UI and functionality are optimized for macOS.

3. **Select My Mac as the Run Destination:**

   - In the device selector, choose **My Mac**.

4. **Build and Run:**

   - Press the **Run** button (▶️) or choose **Product > Run**.
   - Xcode will build and launch the app on your Mac.

   *Note: Some iOS features may not be available or may require modification to work on macOS.* citeturn0search2

## Contributing

Contributions are welcome! To contribute:

1. **Fork the Repository:** Click the **Fork** button at the top right corner of the repository page.
2. **Create a Feature Branch:** In your forked repository, create a new branch for your feature or bug fix.
3. **Implement Your Changes:** Develop your feature or fix in your branch.
4. **Submit a Pull Request:** Once your changes are ready, submit a pull request to the main repository for review.

Please ensure your code adheres to the project's coding standards and includes appropriate tests.
