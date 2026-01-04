# CareSphere - A Unified Healthcare Ecosystem

**CareSphere** is a mobile-first healthcare application designed to bridge the gap between patients and healthcare providers. It leverages the power of Flutter for cross-platform performance and Google Gemini AI for intelligent health assistance, offering a seamless experience for appointment booking, real-time queue tracking, and family health management.

---

## 🚩 Problem Statement
Healthcare accessibility remains a global challenge, characterized by fragmented services, long hospital wait times, and a lack of immediate, reliable health information. 
- **Patients**, especially the elderly and those in remote areas, struggle with booking appointments and managing complex family health records.
- **Healthcare Providers** face inefficiencies in managing patient queues and records manually.
- **Access** to essential medicines and immediate medical advice is often delayed.

## 💡 Solution Approach
CareSphere addresses these issues by creating a unified ecosystem:
- **For Patients:** A seamless interface to book appointments, track live queues in real-time to minimize waiting, and manage entire family health profiles in one secure location.
- **For Doctors:** A specialized "Doctor Mode" to digitally manage schedules, appointments, and patient records.
- **AI Integration:** Integrated **Google Gemini AI** provides an intelligent "AI Assistant" for instant medical guidance, symptom analysis, and health tips.
- **Medicine Marketplace:** A localized digital shop for ordering pharmaceutical needs with rapid delivery.

## 🚀 Impact
- **Efficiency:** Significantly reduces patient wait times through live queue tracking.
- **Accessibility:** Democratizes access to health advice via the AI Assistant.
- **Better Outcomes:** Centralized family records lead to more informed medical decisions.

---

## 🛠️ Technology Stack

### Core Framework
- **Flutter**: For building a high-performance, natively compiled application for mobile from a single codebase.

### Backend & Services (Google Cloud / Firebase)
- **Firebase Authentication**: Secure user identity management for patients and doctors.
- **Cloud Firestore**: Real-time NoSQL database for syncing appointments, user profiles, and medical records.
- **Google Generative AI (Gemini)**: Powers the in-app medical assistant for natural language health queries.

### Key Packages
- `google_generative_ai`: Gemini AI integration.
- `firebase_auth`, `cloud_firestore`: Backend integration.
- `email_otp`: For verifying user emails.
- `provider` / `flutter_riverpod` (implied): State management.

---

## 🤖 Google Technologies Integration
CareSphere proudly integrates the following Google technologies to deliver a robust solution:
1.  **Flutter Framework**: Visuals and Logic.
2.  **Firebase Authentication**: Security and Login.
3.  **Cloud Firestore**: Real-time Data.
4.  **Google Gemini AI**: Intelligent Medical Assistance.

---

## 📦 Installation & Setup

Follow these steps to set up the project locally.

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
- An IDE (VS Code, Android Studio) with Flutter & Dart plugins.
- A GitHub account.

### 1. Clone the Repository
```bash
git clone https://github.com/Nusarat-Praveen/CareSphere.git
cd CareSphere
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Configuration
*Note: This project relies on Firebase. You will need your own `google-services.json` (Android) / `GoogleService-Info.plist` (iOS) files if you want to run it connected to your own project, or ask the team for access.*

### 4. Run the App
Connect a physical device or start an emulator/simulator.
```bash
flutter run
```

---

## 👥 Made By

Made with ❤️ by **Hackstreet Squad**

We are a team of passionate developers aimed at revolutionizing healthcare accessibility through technology.

---

*This project was developed for the [Hackathon Name/Event] 2024.*
