# PixelMart

A multi-module Flutter shopping application that consumes the public DummyJSON REST API. Developed as part of a college assignment to demonstrate proficiency in Flutter development, API integration, clean architecture, and state management.

---

# Overview

PixelMart is a full-featured e-commerce application built with Flutter. The project demonstrates the following key competencies:

- Making and structuring HTTP requests (GET, POST, PUT, DELETE)
- Handling asynchronous programming correctly (Future, async/await, loading/error/success states)
- Implementing Clean Architecture (Uncle Bob) with separation of concerns across layers
- Form handling and validation
- Navigation between screens using `go_router`
- Responsive design across phone, tablet, and web breakpoints
- Robust error handling for network failures, bad status codes, malformed data, and timeouts

---

# Features

## Authentication

- Login with DummyJSON API credentials
- Secure token storage using `flutter_secure_storage`
- Route protection with `go_router` redirects
- Automatic logout on 401 errors

## Products

- Grid view with infinite scroll pagination
- Category filtering
- Product search using `SearchDelegate`
- Product detail with image carousel
- Hero animations from list to detail
- Image previewer with pinch-to-zoom

## Cart

- Add items with quantity selection
- View cart with item list
- Update quantities
- Remove items
- Checkout with confirmation dialog
- Cart badge showing item count

## Recipes

- List view with tag filtering
- Recipe detail with ingredients and instructions
- Hero animations

## Posts

- Create, view, and delete posts
- User-specific post filtering
- Comments system

## Comments

- View comments on posts
- Add new comments
- Delete own comments

---

# Tech Stack

| Category | Technology |
|-----------|------------|
| Framework | Flutter 3.x (Stable) |
| Language | Dart 3.x (Null Safety) |
| HTTP Client | Dio |
| Navigation | go_router |
| State Management | Provider |
| Local Storage | shared_preferences, flutter_secure_storage |
| Image Loading | cached_network_image |
| Image Viewer | photo_view |
| Animations | Lottie |
| Forms | flutter_form_builder |
| Architecture | Clean Architecture |

---

# Architecture

This project follows **Clean Architecture (Uncle Bob)** with three layers.

## Presentation Layer

- Screens
- Widgets
- Providers
- UI Rendering
- State Management
- User Interactions

## Domain Layer

- Entities
- Use Cases
- Repository Interfaces
- Business Logic (Pure Dart)

## Data Layer

- Models
- Services
- Repository Implementations
- API Calls
- Data Parsing


# Screens

| Screen | Description |
|----------|-------------|
| Splash | Lottie animation with automatic navigation to Login or Home |
| Login | Username and password form with validation |
| Products | Product grid with categories, pagination and search |
| Product Detail | Product images, price, rating, stock, description and Add to Cart |
| Image Previewer | Full-screen image viewer with pinch-to-zoom |
| Cart | View items, update quantities, remove products and checkout |
| Recipes | Recipe listing with tag filtering |
| Recipe Detail | Ingredients, instructions and preparation details |
| Posts | View posts and reactions |
| Post Detail | Full post information |
| Create Post | Create new post with validation |
| Comments | View and add comments for posts |

---

# API Integration

## DummyJSON Endpoints

| Module | Endpoint | Method |
|----------|----------|--------|
| Authentication | `/auth/login` | POST |
| Authentication | `/auth/me` | GET |
| Products | `/products` | GET |
| Products | `/products/search` | GET |
| Products | `/products/{id}` | GET |
| Products | `/products/categories` | GET |
| Cart | `/carts` | GET |
| Cart | `/carts/add` | POST |
| Cart | `/carts/{id}` | PUT |
| Cart | `/carts/{id}` | DELETE |
| Recipes | `/recipes` | GET |
| Recipes | `/recipes/{id}` | GET |
| Recipes | `/recipes/tags` | GET |
| Posts | `/posts` | GET |
| Posts | `/posts/{id}` | GET |
| Posts | `/posts/add` | POST |
| Posts | `/posts/{id}` | DELETE |
| Comments | `/comments/post/{id}` | GET |
| Comments | `/comments/add` | POST |

---

# Setup Instructions

## Prerequisites

- Flutter SDK 3.x or later
- Android Studio or Visual Studio Code
- Android Emulator or Physical Device
- iOS Simulator (macOS only)

## Clone Repository

```bash
git clone https://github.com/yourusername/pixelmart.git
cd pixelmart
```

## Install Dependencies

```bash
flutter pub get
```

## Generate App Icons

```bash
flutter pub run flutter_launcher_icons:main
```

## Run Application

```bash
flutter run
```

## Build Release

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

---

# Running the Application

## Android Emulator

```bash
flutter emulators --launch <emulator_name>
flutter run
```

## iOS Simulator

```bash
open -a Simulator
flutter run
```

## Physical Device

```bash
flutter devices
flutter run -d <device_id>
```

## Web

```bash
flutter run -d chrome
```

---

# Testing

## Run All Tests

```bash
flutter test
```

## Run a Specific Test

```bash
flutter test test/widget_test.dart
```

---

# Project Structure

```text
lib/
├── core/
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── api_endpoints.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   ├── constants.dart
│   │   └── validators.dart
│   └── widgets/
│       └── app_bar_with_logo.dart
│
├── features/
│   ├── auth/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── products/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── cart/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── recipes/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── posts/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── comments/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   └── home/
│       ├── screens/
│       └── widgets/
│
├── main.dart
└── firebase_options.dart
```
# Demo Credentials

Use the following DummyJSON demo accounts.

| Username | Password | Role |
|----------|----------|------|
| `emilys` | `emilyspass` | Admin |
| `michaelw` | `michaelwpass` | User |
| `sophiab` | `sophiabpass` | User |

# References

- DummyJSON API Documentation — https://dummyjson.com/docs
- go_router Package — https://pub.dev/packages/go_router
- Dio Package — https://pub.dev/packages/dio
- Flutter Documentation — https://flutter.dev/docs
- Clean Architecture in Flutter — https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/

---



