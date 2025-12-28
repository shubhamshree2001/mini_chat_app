import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';
import 'package:mini_chat_ai_app/features/home/data/repo/home_repo.dart';

part 'home_cubit.g.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeState());

  Future<void> loadAllAndChatHistoryUsers() async {
    final List<UserModel> allUsers = await homeRepo.getAllUsers();
    final List<UserModel> chatHistoryUser = await homeRepo.loadUserWithChats();
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

  Future<void> refreshChatHistoryUser() async{
    final List<UserModel> chatHistoryUser = await homeRepo.loadUserWithChats();
    if (chatHistoryUser.isNotEmpty) {
      emit(state.copyWith(chatHistoryUsers: chatHistoryUser));
    } else {
      emit(state.copyWith(chatHistoryUsers: const []));
    }
  }

  Future<void> addUser(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: trimmed,
      status: _randomStatus(),
      lastSeenValue: Random().nextInt(59) + 1,
    );

    await homeRepo.saveUser(user);

    emit(
      state.copyWith(
        allUsers: await homeRepo.getAllUsers(),
        userAddedMessage: "User added: $trimmed",
      ),
    );
  }

  List<ChatMessage> loadChatForUser(String userId) {
    return homeRepo.loadChatForUser(userId);
  }

  UserStatus _randomStatus() {
    final rand = Random().nextInt(4);
    return UserStatus.values[rand];
  }

  void clearMessage() {
    emit(state.copyWith(userAddedMessage: null));
  }
}
