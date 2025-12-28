import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';

abstract class ChatRepo {
  Future<String> getMessage();

  Future<void> saveMessage(String userId, ChatMessage message);

  List<ChatMessage> loadChatForUser(String userId);
}
