import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_chat_ai_app/core/cache/chats_cache_manager.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

part 'home_cubit.g.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // final ParkingRepo parkingRepo;

  HomeCubit() : super(HomeState());

  Future<void> loadAllAndChatHistoryUsers() async {
    final List<UserModel> allUsers = ChatCacheManager.loadUsers();
    final List<UserModel> chatHistoryUser =
        ChatCacheManager.loadUsersWithChats();
    if (allUsers.isNotEmpty) {
      if (chatHistoryUser.isNotEmpty) {
        emit(state.copyWith(chatHistoryUsers: chatHistoryUser));
      } else {
        emit(state.copyWith(chatHistoryUsers: const []));
      }
      emit(state.copyWith(allUsers: allUsers));
    } else {
      emit(state.copyWith(allUsers: const []));
    }
  }

  void addUser(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: trimmed,
      status: _randomStatus(),
      lastSeenValue: Random().nextInt(59) + 1,
    );

    ChatCacheManager.saveUser(user);

    emit(
      state.copyWith(
        allUsers: ChatCacheManager.loadUsers(),
        userAddedMessage: "User added: $trimmed",
      ),
    );
  }

  UserStatus _randomStatus() {
    final rand = Random().nextInt(4);
    return UserStatus.values[rand];
  }

  void clearMessage() {
    emit(state.copyWith(userAddedMessage: null));
  }
}
