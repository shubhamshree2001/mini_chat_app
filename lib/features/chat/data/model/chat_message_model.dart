enum MessageOwner { sender, receiver }

class ChatMessage {
  final String id;
  final String text;
  final MessageOwner owner;
  final DateTime time;

  ChatMessage({
    required this.id,
    required this.text,
    required this.owner,
    required this.time,
  });
}
