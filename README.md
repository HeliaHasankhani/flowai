# FlowAI

**FlowAI** is a modern Flutter productivity and AI assistant application built as a professional portfolio project.

The app combines task management, local data persistence, BLoC state management, Clean Architecture, and an AI assistant powered through a custom Next.js backend.

## ✨ Features

* 📋 Create, edit, complete, and delete tasks
* 🔎 Filter tasks by All, Pending, and Completed
* 💾 Persistent local task storage
* 🤖 AI Assistant
* 💬 AI-powered conversations
* ⚡ BLoC state management
* 🏗️ Clean Architecture
* 🔌 Flutter ↔ Next.js API integration
* 🧠 Local AI support with Ollama
* 📱 iOS and Android support
* 🎨 Modern and responsive UI

## 🛠️ Tech Stack

### Mobile App

* **Flutter**
* **Dart**
* **flutter_bloc**
* **Equatable**
* **SharedPreferences**
* **HTTP**

### Architecture

The Flutter application follows a Clean Architecture-inspired structure:

```text
lib/
├── core/
│   ├── network/
│   └── theme/
│
├── data/
│   ├── datasources/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   └── repositories/
│
└── presentation/
    ├── bloc/
    │   ├── ai/
    │   └── task/
    │
    ├── screens/
    │   └── ...
    │
    └──
The backend is built with:

Next.js
TypeScript
Ollama
Qwen 3 8B
🚀 Getting Started
1. Clone the repository
git clone https://github.com/HeliaHasankhani/flowai.git
cd flowai
2. Install Flutter dependencies
flutter pub get
3. Run the Flutter application
flutter run

You can also run it on a specific device:

flutter run -d ios

or use an Android emulator/device.

🧠 Running the AI Backend Locally

Make sure Ollama is installed and running.

Pull the model:

ollama pull qwen3:8b

Start the backend:

cd backend
npm install
npm run dev

The Next.js backend will run on:

http://localhost:3000

The Flutter app communicates with:

POST /api/chat
Example request
{
  "message": "Create a study plan for learning Flutter"
}
Example response
{
  "message": "Here is a study plan..."
}
🔐 Environment Variables

Sensitive configuration should be stored in environment files and should never be committed to Git.

For local development, create:

backend/.env.local

Environment files are excluded through .gitignore.

📱 Screens

FlowAI currently includes:

Home Dashboard
Tasks
AI Assistant

The Home screen provides an overview of daily progress and tasks, while the Tasks screen provides full task management.

The AI Assistant provides an interface for interacting with the application's AI backend.

🧪 Development

Run static analysis:

flutter analyze

Run tests:

flutter test

Format Dart code:

dart format lib
📦 Project Structure
flowai/
│
├── android/
├── ios/
├── macos/
├── web/
├── windows/
├── linux/
│
├── lib/
│   ├── core/
│   ├── data/
│   ├── domain/
│   └── presentation/
│
├── backend/
│   └── Next.js + Ollama API
│
├── test/
├── pubspec.yaml
└── README.md
🎯 Project Goals

FlowAI was created to demonstrate practical experience with:

Flutter application development
State management with BLoC
Clean Architecture
Local data persistence
REST API integration
AI integration
Backend development with Next.js
Cross-platform application development

The project is also designed as a foundation for experimenting with more advanced AI-powered productivity features.

🔮 Future Improvements

Planned improvements include:

Improve AI task understanding

AI-generated task suggestions

Better conversation history

User authentication

Cloud synchronization

Remote AI deployment

Production backend

Push notifications

More advanced productivity analytics

Production release for iOS and Android

👩‍💻 Author

Helia Hasankhani

Computer Engineer & Software Developer

GitHub:
https://github.com/HeliaHasankhani

Portfolio:
https://helia-portfolio.vercel.app

📄 License

This project is currently intended as a personal portfolio and learning project.