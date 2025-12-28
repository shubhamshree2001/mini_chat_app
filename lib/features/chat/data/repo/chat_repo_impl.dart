import 'package:mini_chat_ai_app/features/chat/data/datasource/local_data_source.dart';
import 'package:mini_chat_ai_app/features/chat/data/datasource/remote_data_source.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/chat/data/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  ChatRemoteDataSource chatRemoteDataSource;
  ChatLocalDataSource chatLocalDataSource;

  ChatRepoImpl(this.chatRemoteDataSource, this.chatLocalDataSource);

  @override
  Future<String> getMessage() async {
    return await chatRemoteDataSource.getMessage();
  }

  @override
  List<ChatMessage> loadChatForUser(String userId) {
    return chatLocalDataSource.loadChatForUser(userId);
  }

  @override
  Future<void> saveMessage(String userId, ChatMessage message) async {
    await chatLocalDataSource.saveMessage(userId, message);
  }
}
