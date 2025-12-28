import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:mini_chat_ai_app/core/cache/chats_cache_manager.dart';
import 'package:mini_chat_ai_app/core/network/network_client.dart';
import 'package:mini_chat_ai_app/features/chat/data/datasource/local_data_source.dart';
import 'package:mini_chat_ai_app/features/chat/data/datasource/remote_data_source.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_adaptor.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/message_owner_adaptor.dart';
import 'package:mini_chat_ai_app/features/chat/data/repo/chat_repo.dart';
import 'package:mini_chat_ai_app/features/chat/data/repo/chat_repo_impl.dart';
import 'package:mini_chat_ai_app/features/home/data/datasource/local_datasource.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model_adaptor.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_status_adaptor.dart';
import 'package:mini_chat_ai_app/features/home/data/repo/home_repo.dart';
import 'package:mini_chat_ai_app/features/home/data/repo/home_repo_impl.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserStatusAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(MessageOwnerAdapter());
  Hive.registerAdapter(ChatMessageAdapter());

  await Hive.openBox<UserModel>('usersBox');
  await Hive.openBox<List>('chatsBox');

  getIt.registerLazySingleton<http.Client>(() => http.Client());

  getIt.registerLazySingleton<NetworkClientBasicHttp>(
    () => NetworkClientBasicHttp(
      client: getIt<http.Client>(),
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );

  getIt.registerLazySingleton<ChatCacheManager>(() => ChatCacheManager());

  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSource(getIt<NetworkClientBasicHttp>()),
  );

  getIt.registerLazySingleton<ChatLocalDataSource>(
    () => ChatLocalDataSource(getIt<ChatCacheManager>()),
  );

  getIt.registerLazySingleton<ChatRepo>(
    () => ChatRepoImpl(
      getIt<ChatRemoteDataSource>(),
      getIt<ChatLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSource(getIt<ChatCacheManager>()),
  );

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(getIt<HomeLocalDataSource>()),
  );
}
