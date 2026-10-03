# 💧 JalDrishti

JalDrishti is a comprehensive rural water management platform comprising a highly interactive **Mobile Application** for citizens and a powerful **Web Dashboard** for administrators. The system is designed to provide real-time updates on water supply functionality, enable citizens to instantly report issues, and empower administrators to monitor regional water infrastructure dynamically.

---

## 🚀 Features

### 📱 Citizen App (Mobile)
Built with **Flutter** for a premium, buttery-smooth native experience.
* **Rich Animations:** Uses purely native Flutter `AnimationController`s, `TweenAnimationBuilder`, and `AnimatedSwitcher` to deliver a lively, premium 120-fps user experience without heavy external libraries.
* **Multi-lingual Support:** Seamless, instant language switching between English, Hindi (हिंदी), and Marathi (मराठी) without destroying the app state or refreshing the UI.
* **Live Status:** A beautifully animated real-time status card indicating the operational state of the water supply (e.g., functional or interrupted).
* **Incident Reporting:** Citizens can submit incident reports (No Water, Broken Pipe, etc.), attach photos, and automatically append their geolocation for rapid resolution.

### 💻 Admin Dashboard (Web)
Built with **Next.js 15 App Router** for lightning-fast server-side rendering and static caching.
* **Real-time Analytics:** Features interactive, sparkline-embedded KPI cards tracking Functional FHTCs and resolution times.
* **Geospatial Mapping:** Integrates OpenStreetMap via Leaflet (`react-leaflet`) for a live, interactive map of water assets and active complaints, entirely bypassing proprietary mapping APIs.
* **Live Issue Tracking:** An automated polling system fetches active tickets from the connected mobile clients in real-time, displaying them in a comprehensive datatable.
* **Premium UI/UX:** Styled completely from scratch using vanilla CSS, adhering to modern web design principles (glassmorphism, tailored HSL color palettes, micro-animations).

---

## 🛠️ Technology Stack

* **Frontend (Web):** Next.js 15, React, Recharts (Data Visualization), Lucide React (Icons), React-Leaflet (Mapping)
* **Frontend (Mobile):** Flutter, Dart, SharedPreferences, http
* **Backend:** Next.js API Routes (Serverless), JSON file-based database for rapid prototyping
* **Tooling:** Git, Node.js (v20+), Android SDK

---

## ⚙️ How to Run Locally

### 1. Web Dashboard
The web dashboard operates on port 3000 by default.
```bash
cd web-dashboard
npm install
npm run dev
```

### 2. Citizen App
The mobile app communicates with the web dashboard API. Ensure the web dashboard is running first.

```bash
cd citizen_app
flutter pub get
```

*Note: For the best animation performance on a physical device, always run the app in profile or release mode:*
```bash
flutter run --profile
```

### ⚠️ Important Note on Networking
By default, the Flutter app is configured to talk to the local Next.js server via `http://YOUR_LOCAL_IP:3000`. 
If you are testing on a physical Android device, ensure that:
1. The phone and the computer are on the same Wi-Fi network.
2. The computer's firewall permits incoming traffic on port 3000.
3. The app is allowed to send cleartext HTTP traffic (already enabled in `AndroidManifest.xml`).

---
*Built with ❤️ for better water infrastructure.*
