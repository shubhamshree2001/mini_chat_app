// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState isLoading(bool isLoading);

  HomeState error(String? error);

  HomeState allUsers(List<UserModel> allUsers);

  HomeState chatHistoryUsers(List<UserModel> chatHistoryUsers);

  HomeState userAddedMessage(String? userAddedMessage);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `HomeState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ```
  HomeState call({
    bool isLoading,
    String? error,
    List<UserModel> allUsers,
    List<UserModel> chatHistoryUsers,
    String? userAddedMessage,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfHomeState.copyWith(...)` or call `instanceOfHomeState.copyWith.fieldName(value)` for a single field.
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  const _$HomeStateCWProxyImpl(this._value);

  final HomeState _value;

  @override
  HomeState isLoading(bool isLoading) => call(isLoading: isLoading);

  @override
  HomeState error(String? error) => call(error: error);

  @override
  HomeState allUsers(List<UserModel> allUsers) => call(allUsers: allUsers);

  @override
  HomeState chatHistoryUsers(List<UserModel> chatHistoryUsers) =>
      call(chatHistoryUsers: chatHistoryUsers);

  @override
  HomeState userAddedMessage(String? userAddedMessage) =>
      call(userAddedMessage: userAddedMessage);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `HomeState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ```
  HomeState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? allUsers = const $CopyWithPlaceholder(),
    Object? chatHistoryUsers = const $CopyWithPlaceholder(),
    Object? userAddedMessage = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as String?,
      allUsers: allUsers == const $CopyWithPlaceholder() || allUsers == null
          ? _value.allUsers
          // ignore: cast_nullable_to_non_nullable
          : allUsers as List<UserModel>,
      chatHistoryUsers:
          chatHistoryUsers == const $CopyWithPlaceholder() ||
              chatHistoryUsers == null
          ? _value.chatHistoryUsers
          // ignore: cast_nullable_to_non_nullable
          : chatHistoryUsers as List<UserModel>,
      userAddedMessage: userAddedMessage == const $CopyWithPlaceholder()
          ? _value.userAddedMessage
          // ignore: cast_nullable_to_non_nullable
          : userAddedMessage as String?,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfHomeState.copyWith(...)` or `instanceOfHomeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}
