# KetoPilot 🚀

A sophisticated Flutter application for metabolic health optimization, focused on gram-centric macro tracking and biomarker monitoring for ketogenic therapy.

# Mission Statement
To provide transformative support and encouragement for individuals who might be:
- a diabetic tracking their glucose and estimated insulin levels
- mental health focused individuals with bipolar disorder, schizophrenia, or epilepsy, tracking ketone levels
- the cancer patient who is augmenting their standard of care with a diet targeting their glucose ketone index (GKI).
- the N=1 citizen scientist who is curious about their own metabolic health
- the loving parent who is taking care of their child due to their epilepsy or type 1 diabetes
- the stalwart endurance athlete who is dialing in their optimal fueling strategy
- a scientist, researcher, and student developing next generation biosensing systems
  
In their own individual way, each is pursuing and enabling transformation through personalized precision management of their metabolic state. 

## 📱 Features

### Core Functionality
- **Gram-Centric Tracking**: Focus on grams rather than calories for precise macro management
- **Smart Goal System**: Different approaches for carbs (limits) vs protein/fat (goals)
- **Biomarker Monitoring**: Track glucose, BHB (ketones), and GKI (Glucose Ketone Index)
- **Real-time Health Status**: Color-coded indicators for optimal, good, and high ranges
- **Animated Progress Bars**: Beautiful visual feedback for daily nutrition progress

### UI/UX Excellence
- **Professional Medical Theme**: Clean, medical-grade green color scheme
- **Responsive Design**: Optimized for all screen sizes from iPhone SE to iPad Pro
- **MacroFactor-Inspired Design**: Clean bottom navigation with floating action button
- **Swipeable Views**: Swipe between Daily and Weekly views for both Nutrition and Biomarkers
- **Smooth Animations**: Polished micro-interactions throughout the app

### Dashboard Features
- **Daily & Weekly Nutrition**: Swipe between daily macro bars and weekly nutrition trends
- **Daily & Weekly Biomarkers**: Toggle between current readings and weekly biomarker patterns
- **GKI Circle Display**: Prominent glucose-ketone index with color-coded health status
- **Quick Actions Grid**: Fast access to logging, food diary, health tracking, and analytics
- **Health Metrics Overview**: Weight, heart rate, and other key indicators
- **Recent Readings**: Timeline of recent glucose and ketone measurements

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- iOS Simulator or Android Emulator
- Xcode (for iOS development)
- Android Studio (for Android development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/rvru/KetoPilot.git
   cd KetoPilot
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate auto route files**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the application**
   ```bash
   # iOS Simulator
   flutter run -d ios
   
   # Android Emulator  
   flutter run -d android
   
   # macOS Desktop
   flutter run -d macos
   
   # Web Browser
   flutter run -d chrome
   ```

## 📊 Core Widgets

### MacroBarsWidget
Displays daily macro consumption with animated vertical bars:
- **Carbs**: Red bars with dotted limit lines
- **Protein**: Blue bars with solid goal lines  
- **Fat**: Green bars with solid goal lines
- Color changes when limits are exceeded

### MoleculeBarsWidget
Shows biomarker readings with health status indicators:
- **Glucose**: Orange bars (mg/dL) with optimal/good/high status
- **BHB**: Yellow bars (mmol/L) with ketosis indicators
- **GKI**: Blue bars with optimal ranges

### SwipeableSectionWidget
Container for Daily/Weekly views with:
- Smooth PageView transitions
- Tab indicators showing current view
- Visual swipe hints
- Consistent action buttons

## 🎨 Design System

### Color Palette
- **Primary**: Medical green (#4CAF50)
- **Secondary**: Complementary medical blue
- **Status Colors**: 
  - Optimal: Green
  - Good: Orange  
  - Critical: Red
- **Background**: Clean whites and light grays

### Typography
- **Headlines**: Bold, medical-grade typography
- **Body Text**: Clean, readable sans-serif
- **Data Values**: Emphasized numerical displays
- **Status Labels**: Color-coded health indicators

## 🏗️ Architecture

### Clean Architecture Implementation
```
lib/
├── core/                   # Core utilities and constants
│   ├── constants/         # App-wide constants
│   ├── themes/           # Theme configuration
│   └── router/           # Auto route configuration
├── features/             # Feature-based organization
│   ├── dashboard/        # Main dashboard feature
│   ├── data_entry/       # Biomarker logging
│   ├── food_diary/       # Nutrition tracking
│   └── health_logging/   # Symptom tracking
└── shared/              # Shared widgets and utilities
    ├── widgets/         # Reusable UI components
    └── extensions/      # Dart extensions
```

### State Management
- **Riverpod**: For reactive state management
- **Freezed**: For immutable data classes
- **Auto Route**: For declarative navigation

## 📈 Data Models

### HealthMetric
```dart
@freezed
class HealthMetric with _$HealthMetric {
  const factory HealthMetric({
    required String id,
    required DateTime timestamp,
    required double value,
    required String unit,
    required HealthMetricType type,
  }) = _HealthMetric;
}
```

### FoodEntry
```dart
@freezed 
class FoodEntry with _$FoodEntry {
  const factory FoodEntry({
    required String id,
    required String name,
    required double carbsGrams,
    required double proteinGrams,
    required double fatGrams,
    required DateTime timestamp,
  }) = _FoodEntry;
}
```

## 🔧 Development Tools

### Code Generation
```bash
# Generate freezed classes
flutter packages pub run build_runner build

# Watch for changes (development)
flutter packages pub run build_runner watch
```

### Testing
```bash
# Run unit tests
flutter test

# Run integration tests  
flutter drive --target=test_driver/app.dart
```

### Build & Release
```bash
# Build for iOS
flutter build ios --release

# Build for Android
flutter build appbundle --release

# Build for macOS
flutter build macos --release

# Build for Web
flutter build web --release
```

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| iOS | ✅ Supported | iOS 11.0+ |
| Android | ✅ Supported | Android 6.0+ (API 23+) |
| macOS | ✅ Supported | macOS 10.14+ |
| Web | ✅ Supported | Chrome, Safari, Firefox |
| Windows | 🔄 Planned | Future release |
| Linux | 🔄 Planned | Future release |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow the established clean architecture patterns
- Use Freezed for data models
- Implement proper error handling
- Add unit tests for new features
- Follow the existing design system
- Ensure responsive design across all screen sizes

# KetoPilot – Android App

KetoPilot is a metabolic health companion designed to support individuals adopting ketogenic metabolic therapy.

## Android Installation (Beta Testing)

You can download and install the Android version of the app using the link below.

### Step 1: Download the APK

Download the APK file from Google Drive:

[https://KetoPilot_apk](https://drive.google.com/drive/folders/1eSZwdQmKa4MQI49mT0Lp32VNZmnQCuFV?usp=sharing)

Download the latest version file.

---

### Step 2: Allow Installation from Unknown Sources

Because the app is not installed from the Google Play Store, Android may block the installation.

If prompted:

1. Tap **Settings**
2. Enable **Allow from this source** or **Install unknown apps** for your browser or file manager.

---

### Step 3: Install the App

1. Open the downloaded **APK file**
2. Find it in **Files**
3. Tap **Install** and allow scanning
4. Wait for the installation to complete

---

### Step 4: Open the App

After installation:

1. Tap **Open**, or  
2. Find **KetoPilot** in your phone’s app list.

---

## Updating the App

When a new version is released:

1. Download the new APK
2. Install it normally
3. Android will automatically update the existing app

No need to uninstall the previous version.

---

## Notes

- This app is currently in **beta testing**
- Some features may still change
- If you encounter bugs, please report them via GitHub Issues
