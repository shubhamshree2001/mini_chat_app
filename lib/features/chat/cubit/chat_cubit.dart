import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/chat/data/repo/chat_repo.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

part 'chat_cubit.g.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;

  ChatCubit(this.chatRepo) : super(ChatState());

  /// Called when ChatScreen opens
  void loadChat(UserModel user) {
    final messages = chatRepo.loadChatForUser(user.id);
    emit(state.copyWith(selectedUser: user, allMessages: messages));
  }

  Future<void> sendMessage(String text) async {
    final user = state.selectedUser;
    if (user == null || text.trim().isEmpty) return;

    final senderMessage = ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text,
      owner: MessageOwner.sender,
      time: DateTime.now(),
    );

    final messagesAfterSender = _deduplicate([
      ...state.allMessages,
      senderMessage,
    ]);

    emit(
      state.copyWith(
        allMessages: messagesAfterSender,
        error: null,
      ),
    );
    await chatRepo.saveMessage(user.id, senderMessage);

    try {
      final reply = await chatRepo.getMessage();

      final receiverMessage = ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: reply,
        owner: MessageOwner.receiver,
        time: DateTime.now(),
      );

      final messagesAfterReceiver = _deduplicate([
        ...state.allMessages,
        receiverMessage,
      ]);

      emit(
        state.copyWith(
          allMessages: messagesAfterReceiver,
        ),
      );

      await chatRepo.saveMessage(user.id, receiverMessage);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to receive message'));
    }
  }

  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  List<ChatMessage> _deduplicate(List<ChatMessage> messages) {
    final map = <String, ChatMessage>{};

    for (final msg in messages) {
      map[msg.id] = msg;
    }

    return map.values.toList()
      ..sort((a, b) => a.time.compareTo(b.time));
  }
}
