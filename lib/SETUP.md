# 🚀 Project Setup Guide

## ✅ Required Versions

| Tool        | Version          |
|-------------|------------------|
| Flutter     | 3.32.5           |
| Dart        | 3.8.1            |
| JDK         | 17               |
| Kotlin      | 2.0.0+           |
| AGP         | 8.11.0           |
| Gradle      | 8.13             |

## 📦 How to Setup

1. Clone repository ```git clone https://github.com/weltitob/BitNetGithub.git```
2. Install [Flutter](https://flutter.dev/docs/get-started/install)
3. Set JAVA_HOME to JDK 17
4. run ```flutter gen-l10n``` in terminal to generate localization .dart files
5. Run:
    ```
    flutter pub get
    flutter doctor
    ```
6. run ```flutter pub run build_runner build --delete-conflicting-outputs``` to generate mock files for unit tests
7. To run app:
    ```flutter run```

## 🛠 Additional Setup
- Android Studio required for android development
- Xcode required for IOS development