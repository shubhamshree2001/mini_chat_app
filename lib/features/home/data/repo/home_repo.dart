import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

abstract class HomeRepo {
  Future<List<UserModel>> getAllUsers();

  Future<List<UserModel>> loadUserWithChats();

  Future<void> saveUser(UserModel user);

  List<ChatMessage> loadChatForUser(String userId);
}
