import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mini_chat_ai_app/core/cache/chats_cache_manager.dart';
import 'package:mini_chat_ai_app/features/chat/data/datasource/local_data_source.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';

class MockChatCacheManager extends Mock
    implements ChatCacheManager {}

void main() {
  late ChatLocalDataSource dataSource;
  late MockChatCacheManager mockCacheManager;

  const userId = 'user_1';

  final chatMessage = ChatMessage(
    id: 'msg_1',
    text: 'Hello',
    owner: MessageOwner.sender,
    time: DateTime(2025, 1, 1, 10, 0),
  );

  setUp(() {
    mockCacheManager = MockChatCacheManager();
    dataSource = ChatLocalDataSource(mockCacheManager);
  });

  group('ChatLocalDataSource', () {
    test('saveMessage delegates saving to ChatCacheManager', () async {
      // Arrange
      when(
            () => mockCacheManager.saveMessage(userId, chatMessage),
      ).thenAnswer((_) async {});

      // Act
      await dataSource.saveMessage(userId, chatMessage);

      // Assert
      verify(
            () => mockCacheManager.saveMessage(userId, chatMessage),
      ).called(1);

      verifyNoMoreInteractions(mockCacheManager);
    });

    test('loadChatForUser returns chat list from ChatCacheManager', () {
      // Arrange
      when(
            () => mockCacheManager.loadChatsForUser(userId),
      ).thenReturn([chatMessage]);

      // Act
      final result = dataSource.loadChatForUser(userId);

      // Assert
      expect(result, isA<List<ChatMessage>>());
      expect(result.length, 1);
      expect(result.first.text, 'Hello');
      expect(result.first.owner, MessageOwner.sender);

      verify(
            () => mockCacheManager.loadChatsForUser(userId),
      ).called(1);

      verifyNoMoreInteractions(mockCacheManager);
    });
  });
}
