import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mini_chat_ai_app/core/network/network_client.dart';
import 'package:mocktail/mocktail.dart';



class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockClient;
  late NetworkClientBasicHttp networkClient;

  const baseUrl = 'https://example.com';

  setUp(() {
    mockClient = MockHttpClient();
    networkClient = NetworkClientBasicHttp(
      client: mockClient,
      baseUrl: baseUrl,
    );
  });

  group('NetworkClientBasicHttp - GET', () {
    test('returns decoded json when status code is 200', () async {
      // Arrange
      final uri = Uri.parse('$baseUrl/test');

      when(
            () => mockClient.get(
          uri,
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
            (_) async => http.Response(
          jsonEncode({'message': 'success'}),
          200,
        ),
      );

      // Act
      final result = await networkClient.get('/test');

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['message'], 'success');

      verify(
            () => mockClient.get(
          uri,
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    test('throws exception when status code is not 200', () async {
      // Arrange
      final uri = Uri.parse('$baseUrl/test');

      when(
            () => mockClient.get(
          uri,
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
            (_) async => http.Response('Unauthorized', 401),
      );

      // Act & Assert
      expect(
            () => networkClient.get('/test'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('NetworkClientBasicHttp - POST', () {
    test('returns decoded json when status code is 200', () async {
      // Arrange
      final uri = Uri.parse('$baseUrl/login');

      when(
            () => mockClient.post(
          uri,
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
            (invocation) async {
          final body = invocation.namedArguments[#body] as String?;
          final decoded = jsonDecode(body!);

          expect(decoded['email'], 'test@test.com');

          return http.Response(
            jsonEncode({'token': 'abc123'}),
            200,
          );
        },
      );

      // Act
      final result = await networkClient.post(
        '/login',
        body: {
          'email': 'test@test.com',
          'password': '1234',
        },
      );

      // Assert
      expect(result['token'], 'abc123');

      verify(
            () => mockClient.post(
          uri,
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).called(1);
    });

    test('throws exception when status code is not 200', () async {
      // Arrange
      final uri = Uri.parse('$baseUrl/login');

      when(
            () => mockClient.post(
          uri,
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
            (_) async => http.Response('Bad Request', 400),
      );

      // Act & Assert
      expect(
            () => networkClient.post('/login'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
