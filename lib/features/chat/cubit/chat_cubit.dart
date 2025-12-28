import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mini_chat_ai_app/core/cache/chats_cache_manager.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

part 'chat_cubit.g.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  // final ParkingRepo parkingRepo;

  ChatCubit() : super(ChatState());


  /// Called when ChatScreen opens
  void loadChat(UserModel user) {
    final messages = ChatCacheManager.loadChatsForUser(user.id);
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
    ChatCacheManager.saveMessage(user.id, senderMessage);

    // Emit updated messages
    emit(
      state.copyWith(
        allMessages: ChatCacheManager.loadChatsForUser(user.id),
        isLoading: true,
        error: null,
      ),
    );

    try {
      //Fetch receiver reply
      final reply = await fetchReply();

      final receiverMessage = ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: reply,
        owner: MessageOwner.receiver,
        time: DateTime.now(),
      );

      //save receiver message
      ChatCacheManager.saveMessage(user.id, receiverMessage);

      // Emit final state
      emit(
        state.copyWith(
          allMessages: ChatCacheManager.loadChatsForUser(user.id),
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: 'Failed to receive message'),
      );
    }
  }



  Future<String> fetchReply() async {
    final res = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/comments/1"),
    );
    return jsonDecode(res.body)['body'];
  }

  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }
}
