/// Main API service that provides access to all API services
class ApiService {
  final ApiClient _apiClient;

  // Services
  late final AuthService auth;
  late final FoodService food;
  late final DietService diet;
  late final HealthService health;
  late final SummaryService summary;
  late final PhotoService photo;

  ApiService({String? baseUrl}) : _apiClient = ApiClient(baseUrl: baseUrl) {
    auth = AuthService(_apiClient);
    food = FoodService(_apiClient);
    diet = DietService(_apiClient);
    health = HealthService(_apiClient);
    summary = SummaryService(_apiClient);
    photo = PhotoService(_apiClient);
  }

  /// Set authentication token
  void setAuthToken(String token) {
    _apiClient.setAuthToken(token);
  }

  /// Clear authentication token
  void clearAuthToken() {
    _apiClient.clearAuthToken();
  }
}

