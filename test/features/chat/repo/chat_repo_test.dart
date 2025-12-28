import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mini_chat_ai_app/features/chat/data/datasource/local_data_source.dart';
import 'package:mini_chat_ai_app/features/chat/data/datasource/remote_data_source.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/chat/data/repo/chat_repo_impl.dart';

class MockChatRemoteDataSource extends Mock
    implements ChatRemoteDataSource {}

class MockChatLocalDataSource extends Mock
    implements ChatLocalDataSource {}

void main() {
  late ChatRepoImpl chatRepo;
  late MockChatRemoteDataSource mockRemoteDataSource;
  late MockChatLocalDataSource mockLocalDataSource;

  const userId = 'user_1';

  final chatMessage = ChatMessage(
    id: 'msg_1',
    text: 'Hello',
    owner: MessageOwner.sender,
    time: DateTime(2025, 1, 1, 10, 0),
  );

  setUp(() {
    mockRemoteDataSource = MockChatRemoteDataSource();
    mockLocalDataSource = MockChatLocalDataSource();

    chatRepo = ChatRepoImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  group('ChatRepoImpl', () {
    test('getMessage returns message from remote data source', () async {
      // Arrange
      when(() => mockRemoteDataSource.getMessage())
          .thenAnswer((_) async => 'Hello from API');

      // Act
      final result = await chatRepo.getMessage();

      // Assert
      expect(result, 'Hello from API');
      verify(() => mockRemoteDataSource.getMessage()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('loadChatForUser returns chat messages from local data source', () {
      // Arrange
      when(() => mockLocalDataSource.loadChatForUser(userId))
          .thenReturn([chatMessage]);

      // Act
      final result = chatRepo.loadChatForUser(userId);

      // Assert
      expect(result, isA<List<ChatMessage>>());
      expect(result.length, 1);
      expect(result.first.text, 'Hello');
      expect(result.first.owner, MessageOwner.sender);

      verify(() => mockLocalDataSource.loadChatForUser(userId)).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('saveMessage delegates saving to local data source', () async {
      // Arrange
      when(
            () => mockLocalDataSource.saveMessage(userId, chatMessage),
      ).thenAnswer((_) async {});

      // Act
      await chatRepo.saveMessage(userId, chatMessage);

      // Assert
      verify(
            () => mockLocalDataSource.saveMessage(userId, chatMessage),
      ).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}
