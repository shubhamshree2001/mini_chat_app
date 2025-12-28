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

    // Create sender message
    final senderMessage = ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text,
      owner: MessageOwner.sender,
      time: DateTime.now(),
    );

    //save sender message
   // chatRepo.saveMessage(user.id, senderMessage);
    final updatedMessages = List<ChatMessage>.from(state.allMessages)
      ..add(senderMessage);
    // Emit updated messages
    emit(state.copyWith(allMessages: updatedMessages, error: null));
    //allMessages: chatRepo.loadChatsForUser(user.id),

    try {
      //Fetch receiver reply
      final reply = await chatRepo.getMessage();

      final receiverMessage = ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: reply,
        owner: MessageOwner.receiver,
        time: DateTime.now(),
      );

      //save receiver message
      final updatedMessages1 = List<ChatMessage>.from(state.allMessages)
        ..add(receiverMessage);

      // Emit final state
      emit(state.copyWith(allMessages: updatedMessages1));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to receive message'));
    }
  }

  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }
}
