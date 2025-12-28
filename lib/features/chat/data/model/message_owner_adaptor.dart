import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';

class MessageOwnerAdapter extends TypeAdapter<MessageOwner> {
  @override
  final int typeId = 2;

  @override
  MessageOwner read(BinaryReader reader) =>
      MessageOwner.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, MessageOwner obj) =>
      writer.writeInt(obj.index);
}
