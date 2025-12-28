enum UserStatus { online, minutesAgo, hoursAgo, offline }

class UserModel {
  final String id;
  final String name;
  final UserStatus status;
  final int lastSeenValue; // minutes / hours

  UserModel({
    required this.id,
    required this.name,
    required this.status,
    required this.lastSeenValue,
  });

  String get initial => name[0].toUpperCase();

  String get statusText {
    switch (status) {
      case UserStatus.online:
        return "Online";
      case UserStatus.minutesAgo:
        return "$lastSeenValue min ago";
      case UserStatus.hoursAgo:
        return "$lastSeenValue hour ago";
      case UserStatus.offline:
        return "Offline";
    }
  }

  bool get isOnline => status == UserStatus.online;
}
