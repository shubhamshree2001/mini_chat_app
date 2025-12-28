import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/home/data/datasource/local_datasource.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';
import 'package:mini_chat_ai_app/features/home/data/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl(this.homeLocalDataSource);

  @override
  Future<List<UserModel>> getAllUsers() async {
    return await homeLocalDataSource.getAllUsers();
  }

  @override
  Future<List<UserModel>> loadUserWithChats() async {
    return await homeLocalDataSource.loadUserWithChats();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await homeLocalDataSource.saveUsers(user);
  }

  @override
  List<ChatMessage> loadChatForUser(String userId) {
    return homeLocalDataSource.loadChatForUser(userId);
  }
}
