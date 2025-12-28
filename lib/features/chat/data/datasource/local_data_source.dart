import 'package:mini_chat_ai_app/core/cache/chats_cache_manager.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';

class ChatLocalDataSource {
  final ChatCacheManager chatCacheManager;

  ChatLocalDataSource(this.chatCacheManager);

  Future<void> saveMessage(String userId, ChatMessage message) async {
    await chatCacheManager.saveMessage(userId, message);
  }

  List<ChatMessage> loadChatForUser(String userId) {
    final List<ChatMessage> loadChatsOfUser = chatCacheManager.loadChatsForUser(
      userId,
    );
    return loadChatsOfUser;
  }
}
