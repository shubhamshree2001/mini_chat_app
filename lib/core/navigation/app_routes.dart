import 'package:flutter/material.dart';
import 'package:mini_chat_ai_app/features/app_shell/presentation/app_shell_screen.dart';
import 'package:mini_chat_ai_app/features/chat/presentation/chat_screen.dart';
import 'package:mini_chat_ai_app/features/splash/presentation/splash_screen.dart';

class Routes {
  static const initial = '/';
  static const splashScreen = '/splashScreen';
  static const mainTabs = '/mainTabs';
  static const homeScreen = '/homeScreen';
  static const chatScreen = '/chatScreen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    mainTabs: (context) => const MainTabs(),
    chatScreen: (context) => const ChatScreen(),
  };
}
