import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_adaptor.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/message_owner_adaptor.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model_adaptor.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_status_adaptor.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserStatusAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(MessageOwnerAdapter());
  Hive.registerAdapter(ChatMessageAdapter());

  await Hive.openBox<UserModel>('usersBox');
  await Hive.openBox<List>('chatsBox');
}
