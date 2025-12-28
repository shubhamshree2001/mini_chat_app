import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';

class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = 3;

  @override
  ChatMessage read(BinaryReader reader) {
    return ChatMessage(
      id: reader.readString(),
      text: reader.readString(),
      owner: MessageOwner.values[reader.readInt()],
      time: DateTime.parse(reader.readString()),
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.text);
    writer.writeInt(obj.owner.index);
    writer.writeString(obj.time.toIso8601String());
  }
}
