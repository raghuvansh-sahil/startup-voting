# Startup Idea Evaluator 🚀

A mobile application that enables users to submit, evaluate, and vote on startup ideas — powered by fun AI-generated feedback and community engagement.

---

## 📌 Project Overview

The **Startup Idea Evaluator** app provides an interactive platform where users can:

- Submit their startup ideas with a name, tagline, and detailed description.
- Receive a simulated AI-generated rating to get instant feedback.
- Vote on other users’ ideas (one vote per idea per user).
- View and sort startup ideas by rating or votes.
- Explore a leaderboard showcasing the top startup ideas.

The app focuses on delivering a seamless multi-screen experience, integrating mock APIs, persistent local storage, and modern mobile UX best practices.

---

## ⚙️ Features

### Idea Submission Screen
- Form inputs: Startup Name, Tagline, Description.
- Generates a fake AI rating (0–100) on submission.
- Saves ideas locally or via mock API.

### Idea Listing Screen
- Displays all ideas with Name, Tagline, Rating, and Vote Count.
- Upvote functionality restricted to one vote per idea per user.
- “Read More...” toggle to expand descriptions.
- Sort ideas by Votes or Rating.

### Leaderboard Screen
- Showcases the top 5 ideas ranked by votes or rating.
- Features badges (🥇🥈🥉).

### Bonus Features (Optional)
- Dark mode toggle.
- Custom fonts and icons for enhanced UI.

---

## 🧑‍💻 Tech Stack

- **Framework:** Flutter (Dart)
- **Storage:** SharedPreferences for persistent local data
- **UI:** Material Design widgets
- **Networking:** HTTP package with mock backend API

---

## 🚀 Installation & Running

### Run Locally

1. Ensure Flutter SDK is installed and set up.
2. Clone the repository:
   ```bash
   git clone https://github.com/raghuvansh-sahil/startup-voting/tree/main
   ```
3. Navigate to the project directory:
  ```bash
  cd startup-idea-evaluator
  ```
4. Fetch dependencies:
  ```bash
  flutter pub get
  ```
5. Run the app on an emulator or physical device:
  ```bash
  flutter run
  ```
6. Install Debug APK
The debug APK can be found in ```build/app/outputs/flutter-apk/app-debug.apk```.

Transfer it to your Android device and install manually.
