# 🍔 Foody Licious App  

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)  
[![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)](https://dart.dev)  
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)  
[![Build](https://github.com/VishnuMate27/foody_licious/actions/workflows/main.yml/badge.svg)](https://github.com/VishnuMate27/foody_licious/actions)  
<!--[![Coverage](https://img.shields.io/codecov/c/github/VishnuMate27/foody_licious)](https://codecov.io/gh/VishnuMate27/foody_licious)-->

A modern **food ordering and delivery app** built with **Flutter**.  
Foody Licious provides a seamless experience to browse restaurants, explore dishes, place orders, and manage profiles — all powered by a clean architecture and test-driven development.  

---

## ✨ Features  

- 🔐 **Authentication** – Sign up, login, logout using Firebase Auth  
- 👤 **User Profile** – Update name, phone, and profile details  
- 🍴 **Browse Restaurants & Dishes** – Explore menus with images, prices, and details  
- 🛒 **Cart & Orders** – Add items to cart, checkout, and track your orders  
- 🔔 **Push Notifications** – Get order updates and special offers  
- 🌐 **Remote & Local Storage** – REST API + local caching with SharedPreferences
- 📊 **State Management** – BLoC pattern for scalable architecture  
- 🧪 **Unit Testing** – Ensuring reliability with test coverage  

---

<!-- 
## 📱 Screenshots  

| Home Screen | Food Details | Cart | Profile |  
|-------------|--------------|------|---------|  
| ![Home](docs/screenshots/home.png) | ![Details](docs/screenshots/details.png) | ![Cart](docs/screenshots/cart.png) | ![Profile](docs/screenshots/profile.png) |  

*(Add your real screenshots inside `docs/screenshots/` folder)*  

---
-->

## 🛠️ Tech Stack  

- **Framework:** [Flutter](https://flutter.dev/)  
- **Language:** Dart  
- **State Management:** BLoC  
- **Backend:** Firebase + REST API (Flask)
- **Database:** MongoDB
- **Storage:** SharedPreferences
- **CI/CD:** GitHub Actions (Android builds)  

---

## 📂 Project Structure  
```md
lib/
│── core/ # Error handling, utilities, constants
│── data/ # Data sources, repositories, models
│ ├── data_sources/
│ ├── models/
│ └── repositories/
│── domain/ # Entities, repository contracts, use cases
│── presentation/ # UI (widgets, screens), BLoC
│── main.dart # App entry point
test/ # Unit & widget tests
```


---

## 🚀 Getting Started  

### Prerequisites  
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable)  
- Dart ≥ 3.0  
- Android Studio / VS Code  
- Firebase Project setup  

### Installation  

```bash
# Clone the repo
git clone https://github.com/your-username/foody_licious.git
cd foody_licious

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### 🧪 Running Tests
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

###🔑 Environment Variables
The app uses dotenv for environment configuration.
Create a .env file in the project root:
```bash
BASE_URL=http://your-api-url
API_KEY=your_api_key
```

###🤝 Contributing

Contributions are welcome! 🎉

1. Fork the repo
2. Create your feature branch (git checkout -b feature/amazing-feature)
3. Commit changes (git commit -m 'Add amazing feature')
4. Push to branch (git push origin feature/amazing-feature)
5. Open a Pull Request

   
## 📜 License  

This project is licensed under the **MIT License**. 

## 👨‍💻 Author
**Vishnu Mate**
💼 [LinkedIn](https://www.linkedin.com/in/vishnumate/) | 🐙 [GitHub](https://github.com/VishnuMate27)
   

