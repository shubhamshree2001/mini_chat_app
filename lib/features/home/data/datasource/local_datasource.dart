import 'package:mini_chat_ai_app/core/cache/chats_cache_manager.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

class HomeLocalDataSource {
  final ChatCacheManager chatCacheManager;

  HomeLocalDataSource(this.chatCacheManager);

  Future<List<UserModel>> getAllUsers() async {
    final List<UserModel> allUsers = chatCacheManager.loadUsers();
    return allUsers;
  }

  Future<List<UserModel>> loadUserWithChats() async {
    final List<UserModel> loadUsersWithChats = chatCacheManager
        .loadUsersWithChats();
    return loadUsersWithChats;
  }

  Future<void> saveUsers(UserModel user) async {
    await chatCacheManager.saveUser(user);
  }

  List<ChatMessage> loadChatForUser(String userId) {
    final List<ChatMessage> loadChatsOfUser = chatCacheManager.loadChatsForUser(
      userId,
    );
    return loadChatsOfUser;
  }
}
