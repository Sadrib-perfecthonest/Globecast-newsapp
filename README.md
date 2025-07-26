# 🌐 Globecast - Modern Flutter News App

**Globecast** is a sleek, fast, and modern Flutter news app that delivers real-time headlines from top global news sources. The app is designed for simplicity, personalization, and speed—ideal for users who want the latest stories without clutter.

---

## 🚀 Features

- 📰 **Top News by Category**  
  Explore news from categories like Technology, Sports, Health, Science, Entertainment, and more.

- 📚 **Bookmark Articles**  
  Save articles to read later in an offline-friendly, clutter-free format.

- ⚙️ **Personalized Settings**  
  - Enable Dark Mode 🌙  
  - Select Preferred News Source (BBC, CNN, ARY News, The New York Times, etc.)  
  - Set Default Category to show on app launch  
  - Adjust Font Style with custom fonts via Google Fonts  
  - Control Notification Preferences 🔔

- 📤 **User Authentication**  
  Simple login and registration system to sync user bookmarks and settings.

- 🏁 **Splash Screen & Smooth Navigation**  
  Clean animated splash with intuitive page transitions using Flutter’s Material and Cupertino widgets.

---

## 📦 Packages Used

| Package             | Purpose                                         |
|---------------------|-------------------------------------------------|
| `cupertino_icons`   | iOS-style icons and theming                     |
| `shared_preferences`| Save user preferences (theme, bookmarks, etc.)  |
| `google_fonts`      | Load custom fonts from Google Fonts             |
| `flutter_spinkit`   | Beautiful loading animations                    |
| `intl`              | Date formatting and internationalization        |
| `carousel_slider`   | Slick sliders for highlighting top stories      |

---

## ❗ Challenges Faced & Solutions

### 1. Dynamic News Source Integration  
**Problem:** Fetching and displaying news from multiple sources with different APIs and formats.  
**Solution:** Built a common parser layer that standardizes responses from various APIs into a unified article model.

### 2. UI Consistency Across Devices  
**Problem:** Maintaining design responsiveness on different screen sizes.  
**Solution:** Used `MediaQuery`, `Flexible`, and `LayoutBuilder` extensively, along with Google Fonts for consistent typography.

### 3. Smooth Theme Switching  
**Problem:** Lag during switching from Light to Dark mode.  
**Solution:** Optimized `ThemeData` setup using `shared_preferences` and app-wide theme management.

---

## 📱 Future Enhancements (2025-Oriented)

- 🗂️ Offline Reading Mode  
- 📍 Location-Based News  
- 🗣️ Text-to-Speech for News Articles  
- 🔍 Voice Command Integration  
- 🧠 AI-Based Personal Feed (based on user reading history)

---

## 🤝 Contributions

Feel free to fork and submit a PR if you'd like to improve Globecast or integrate new features like push notifications, user profile editing, or AI-curated content.

---

## 🧑‍💻 Developed With ❤️ Using Flutter

Stay informed, stay global with **Globecast**.

