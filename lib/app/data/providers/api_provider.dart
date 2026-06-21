import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../utils/api_constants.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class ApiProvider {
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> getTopHeadlines({
    required String category,
    int page = 1,
  }) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiConstants.topHeadlines}"
      "?category=$category"
      "&country=${ApiConstants.defaultCountry}"
      "&page=$page"
      "&pageSize=${ApiConstants.pageSize}"
      "&apiKey=${ApiConstants.apiKey}",
    );
    return _get(uri);
  }

  Future<Map<String, dynamic>> searchNews({
    required String query,
    int page = 1,
  }) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiConstants.everything}"
      "?q=${Uri.encodeQueryComponent(query)}"
      "&page=$page"
      "&pageSize=${ApiConstants.pageSize}"
      "&sortBy=publishedAt"
      "&apiKey=${ApiConstants.apiKey}",
    );
    return _get(uri);
  }

  Future<Map<String, dynamic>> _get(Uri uri) async {
    http.Response response;

    try {
      response = await _client
          .get(uri)
          .timeout(Duration(seconds: ApiConstants.requestTimeoutSeconds));
    } on SocketException {
      throw ApiException(
        "No internet connection. Please check your network and try again.",
      );
    } on TimeoutException {
      throw ApiException("The request timed out. Please try again.");
    } on HttpException {
      throw ApiException("Could not reach the server. Please try again later.");
    } catch (e) {
      throw ApiException("Something went wrong while connecting: $e");
    }

    Map<String, dynamic> decoded;
    try {
      decoded = jsonDecode(response.body) as Map<String, dynamic>;
    } on FormatException {
      throw ApiException("Received an invalid response from the server.");
    }

    if (response.statusCode == 200 && decoded['status'] == 'ok') {
      return decoded;
    }

    final apiMessage = decoded['message'] as String?;

    switch (response.statusCode) {
      case 401:
        throw ApiException(
          "Invalid API key. Please add a valid NewsAPI key in api_constants.dart.",
        );
      case 429:
        throw ApiException(
          "Too many requests. The free NewsAPI plan has a rate limit, please wait a moment.",
        );
      default:
        throw ApiException(
          apiMessage ?? "Something went wrong. Please try again.",
        );
    }
  }
}
