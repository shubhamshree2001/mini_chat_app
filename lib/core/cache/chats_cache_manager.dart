import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

//
// class ChatCacheManager {
//
//   static const String usersBoxName = 'usersBox';
//   static const String chatsBoxName = 'chatsBox';
//
//
//   /// Save a new user
//   static Future<void> saveUser(UserModel user) async {
//     final box = Hive.box<UserModel>(usersBoxName);
//     await box.put(user.id, user);
//   }
//
//   /// Load all users
//   static List<UserModel> loadUsers() {
//     final box = Hive.box<UserModel>(usersBoxName);
//     return box.values.toList();
//   }
//
//   /// Find user by id
//   static UserModel? findUser(String userId) {
//     final box = Hive.box<UserModel>(usersBoxName);
//     return box.get(userId);
//   }
//
//   /// Delete user and its chats
//   static Future<void> deleteUser(String userId) async {
//     final usersBox = Hive.box<UserModel>(usersBoxName);
//     final chatsBox = Hive.box<List>(chatsBoxName);
//
//     await usersBox.delete(userId);
//     await chatsBox.delete(userId);
//   }
//
//
//   /// Save a message for a specific user
//   static Future<void> saveMessage(String userId, ChatMessage message) async {
//     final box = Hive.box<List>(chatsBoxName);
//
//     final List<ChatMessage> messages =
//         (box.get(userId) as List?)?.cast<ChatMessage>() ?? [];
//
//     messages.add(message);
//
//     await box.put(userId, messages);
//   }
//
//   /// Load chats for a specific user
//   static List<ChatMessage> loadChatsForUser(String userId) {
//     final box = Hive.box<List>(chatsBoxName);
//     return (box.get(userId) as List?)?.cast<ChatMessage>() ?? [];
//   }
//
//   /// Check if user has any chats
//   static bool hasChats(String userId) {
//     final box = Hive.box<List>(chatsBoxName);
//     final messages = box.get(userId);
//     return messages != null && messages.isNotEmpty;
//   }
//
//   /// Load users who have chats (Chat History tab)
//   static List<UserModel> loadUsersWithChats() {
//     final usersBox = Hive.box<UserModel>(usersBoxName);
//     final chatsBox = Hive.box<List>(chatsBoxName);
//
//     return usersBox.values.where((user) {
//       final messages = chatsBox.get(user.id);
//       return messages != null && messages.isNotEmpty;
//     }).toList();
//   }
//
//
//   static Future<void> clearAll() async {
//     await Hive.box<UserModel>(usersBoxName).clear();
//     await Hive.box<List>(chatsBoxName).clear();
//   }
// }

class ChatCacheManager {
  static const String usersBoxName = 'usersBox';
  static const String chatsBoxName = 'chatsBox';

  Future<void> saveUser(UserModel user) async {
    final box = Hive.box<UserModel>(usersBoxName);
    await box.put(user.id, user);
  }

  List<UserModel> loadUsers() {
    final box = Hive.box<UserModel>(usersBoxName);
    return box.values.toList();
  }

  UserModel? findUser(String userId) {
    final box = Hive.box<UserModel>(usersBoxName);
    return box.get(userId);
  }

  Future<void> deleteUser(String userId) async {
    final usersBox = Hive.box<UserModel>(usersBoxName);
    final chatsBox = Hive.box<List>(chatsBoxName);

    await usersBox.delete(userId);
    await chatsBox.delete(userId);
  }

  Future<void> saveMessage(String userId, ChatMessage message) async {
    final box = Hive.box<List>(chatsBoxName);

    final messages = (box.get(userId) as List?)?.cast<ChatMessage>() ?? [];

    messages.add(message);
    await box.put(userId, messages);
  }

  List<ChatMessage> loadChatsForUser(String userId) {
    final box = Hive.box<List>(chatsBoxName);
    return (box.get(userId) as List?)?.cast<ChatMessage>() ?? [];
  }

  bool hasChats(String userId) {
    final box = Hive.box<List>(chatsBoxName);
    final messages = box.get(userId);
    return messages != null && messages.isNotEmpty;
  }

  List<UserModel> loadUsersWithChats() {
    final usersBox = Hive.box<UserModel>(usersBoxName);
    final chatsBox = Hive.box<List>(chatsBoxName);

    return usersBox.values.where((user) {
      final messages = chatsBox.get(user.id);
      return messages != null && messages.isNotEmpty;
    }).toList();
  }

  Future<void> clearAll() async {
    await Hive.box<UserModel>(usersBoxName).clear();
    await Hive.box<List>(chatsBoxName).clear();
  }
}
