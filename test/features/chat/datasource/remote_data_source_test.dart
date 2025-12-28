import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mini_chat_ai_app/core/network/network_client.dart';
import 'package:mini_chat_ai_app/features/chat/data/datasource/remote_data_source.dart';

class MockNetworkClientBasicHttp extends Mock
    implements NetworkClientBasicHttp {}

void main() {
  late ChatRemoteDataSource dataSource;
  late MockNetworkClientBasicHttp mockNetworkClient;

  setUp(() {
    mockNetworkClient = MockNetworkClientBasicHttp();
    dataSource = ChatRemoteDataSource(mockNetworkClient);
  });

  group('ChatRemoteDataSource', () {
    test('getMessage returns body from api response', () async {
      // Arrange
      when(
            () => mockNetworkClient.get('/comments/1'),
      ).thenAnswer(
            (_) async => {
          'postId': 1,
          'id': 1,
          'name': 'test',
          'email': 'test@test.com',
          'body': 'Hello from API',
        },
      );

      // Act
      final result = await dataSource.getMessage();

      // Assert
      expect(result, 'Hello from API');

      verify(
            () => mockNetworkClient.get('/comments/1'),
      ).called(1);

      verifyNoMoreInteractions(mockNetworkClient);
    });

    test('throws error when network client throws', () async {
      // Arrange
      when(
            () => mockNetworkClient.get('/comments/1'),
      ).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
            () => dataSource.getMessage(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
