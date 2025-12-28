// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatStateCWProxy {
  ChatState isLoading(bool isLoading);

  ChatState error(String? error);

  ChatState selectedUser(UserModel? selectedUser);

  ChatState allMessages(List<ChatMessage> allMessages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatState(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatState call({
    bool isLoading,
    String? error,
    UserModel? selectedUser,
    List<ChatMessage> allMessages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChatState.copyWith(...)` or call `instanceOfChatState.copyWith.fieldName(value)` for a single field.
class _$ChatStateCWProxyImpl implements _$ChatStateCWProxy {
  const _$ChatStateCWProxyImpl(this._value);

  final ChatState _value;

  @override
  ChatState isLoading(bool isLoading) => call(isLoading: isLoading);

  @override
  ChatState error(String? error) => call(error: error);

  @override
  ChatState selectedUser(UserModel? selectedUser) =>
      call(selectedUser: selectedUser);

  @override
  ChatState allMessages(List<ChatMessage> allMessages) =>
      call(allMessages: allMessages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatState(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? selectedUser = const $CopyWithPlaceholder(),
    Object? allMessages = const $CopyWithPlaceholder(),
  }) {
    return ChatState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as String?,
      selectedUser: selectedUser == const $CopyWithPlaceholder()
          ? _value.selectedUser
          // ignore: cast_nullable_to_non_nullable
          : selectedUser as UserModel?,
      allMessages:
          allMessages == const $CopyWithPlaceholder() || allMessages == null
          ? _value.allMessages
          // ignore: cast_nullable_to_non_nullable
          : allMessages as List<ChatMessage>,
    );
  }
}

extension $ChatStateCopyWith on ChatState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChatState.copyWith(...)` or `instanceOfChatState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatStateCWProxy get copyWith => _$ChatStateCWProxyImpl(this);
}
