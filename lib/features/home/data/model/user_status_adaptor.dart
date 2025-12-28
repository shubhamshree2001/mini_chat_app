import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

class UserStatusAdapter extends TypeAdapter<UserStatus> {
  @override
  final int typeId = 0;

  @override
  UserStatus read(BinaryReader reader) => UserStatus.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, UserStatus obj) => writer.writeInt(obj.index);
}
