class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://newsapi.org/v2";

  static const String apiKey = "2e50d131025f4061a00949f39070f434";

  static const String topHeadlines = "/top-headlines";
  static const String everything = "/everything";

  static const String defaultCountry = "us";

  static const int pageSize = 20;
  static const int requestTimeoutSeconds = 15;
}
