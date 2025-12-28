import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
      id: reader.readString(),
      name: reader.readString(),
      status: UserStatus.values[reader.readInt()],
      lastSeenValue: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeInt(obj.status.index);
    writer.writeInt(obj.lastSeenValue);
  }
}
