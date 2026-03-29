## Flutter BLoC with REST API (Clean Architecture)

This project demonstrates a production-ready authentication flow using Flutter, BLoC, and a REST API, organized with Clean Architecture and dependency injection. It also includes a polished example Notes UI.

### Tech Stack
- **State management**: `flutter_bloc`
- **Networking**: `dio`
- **Dependency injection**: `get_it`
- **Local storage**: `shared_preferences`
- **Connectivity**: `internet_connection_checker`
- **UI/Fonts**: `google_fonts`, Material 3 theme
- **Dart/Flutter**: SDK constraint `^3.9.2`

### Key Features
- Email/password login via REST API
- Token persistence with `SharedPreferences`
- Auth guard and navigation between `Login` and `Home`
- Centralized API client with interceptors and retry handling
- Layered Clean Architecture (domain, data, presentation)

---
## API Configuration
Update the API base URL and endpoints here:
- `lib/core/network/api_provider.dart`
  - `baseUrl`: default is `"https://example.com"`
  - `loginUri`: `'/api/v1/auth/login'`

Login request body (by default):
```json
{ "email": "<email>", "password": "<password>" }
```

`DioClient` automatically injects headers:
- `Authorization: Bearer <token>` (if available)
- `Content-Type: application/json; charset=UTF-8`

If your API uses different fields or paths, adjust:
- `ApiProvider.loginUri`
- `AuthRemoteDataSourceImpl.login(...)`

---

## Running the App
1. Install Flutter (see Flutter docs) and ensure you’re on a version compatible with Dart `^3.9.2`
2. Fetch dependencies:
   - `flutter pub get`
3. Configure your API:
   - Edit `lib/core/network/api_provider.dart` and set your `baseUrl`
4. Run:
   - `flutter run`

---

## License
MIT
