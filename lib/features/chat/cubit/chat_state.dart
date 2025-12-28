part of 'chat_cubit.dart';

@CopyWith()
class ChatState extends Equatable {
  final bool isLoading;
  final String? error;
  final UserModel? selectedUser;
  final List<ChatMessage> allMessages;
  final String? wordMeaning;

  const ChatState({
    this.isLoading = false,
    this.error,
    this.selectedUser,
    this.allMessages = const [],
    this.wordMeaning,
  });

  @override
  List<Object?> get props => [isLoading, error, selectedUser, allMessages, wordMeaning];
}
