part of 'home_cubit.dart';

@CopyWith()
class HomeState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<UserModel> allUsers;
  final List<UserModel> chatHistoryUsers;
  final String? userAddedMessage;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.allUsers = const [],
    this.chatHistoryUsers = const [],
    this.userAddedMessage,
  });

  @override
  List<Object?> get props => [
    isLoading,
    error,
    allUsers,
    chatHistoryUsers,
    userAddedMessage,
  ];
}
