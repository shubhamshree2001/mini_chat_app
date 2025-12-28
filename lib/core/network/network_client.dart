import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkClientBasicHttp {
  final http.Client client;
  final String baseUrl;

  NetworkClientBasicHttp({
    required this.client,
    required this.baseUrl,
  });

  Map<String, String> buildHeaders() {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    return headers;
  }

  Future<dynamic> get(String path, {Map<String, String>? query}) async {
    try {
      final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
      final response = await client
          .get(uri, headers: buildHeaders())
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw Exception('Http ${response.statusCode}');
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? body,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseUrl$path',
      ).replace(queryParameters: queryParameters);
      final response = await client
          .post(
            uri,
            headers: buildHeaders(),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw Exception('Http ${response.statusCode}');
    } catch (_) {
      rethrow;
    }
  }
}
