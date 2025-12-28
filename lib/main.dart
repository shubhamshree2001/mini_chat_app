import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_chat_ai_app/core/di/service_locator.dart';
import 'package:mini_chat_ai_app/core/navigation/app_routes.dart';
import 'package:mini_chat_ai_app/features/chat/cubit/chat_cubit.dart';
import 'package:mini_chat_ai_app/features/chat/data/repo/chat_repo.dart';
import 'package:mini_chat_ai_app/features/home/cubit/home_cubit.dart';
import 'package:mini_chat_ai_app/features/home/data/repo/home_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeCubit(getIt<HomeRepo>()),
        ),
        BlocProvider(
          create: (BuildContext context) => ChatCubit(getIt<ChatRepo>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        routes: Routes.routes,
      ),
    );
  }
}
