import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_chat_ai_app/core/navigation/app_routes.dart';
import 'package:mini_chat_ai_app/features/home/cubit/home_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasNavigated = false;

  @override
  void initState() {
    super.initState();
    final HomeCubit homeCubit = context.read<HomeCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await insideInitCalledFnc(homeCubit);
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (!hasNavigated && mounted) {
        _navigate();
      }
    });
  }

  Future<void> insideInitCalledFnc(HomeCubit homeCubit) async {
    await Future.wait([homeCubit.loadAllAndChatHistoryUsers()]);
    if (!hasNavigated && mounted) {
      _navigate();
    }
  }

  void _navigate() async {
    if (hasNavigated || !mounted) return;
    hasNavigated = true;
    Navigator.pushReplacementNamed(context, Routes.mainTabs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'My Sivi',
          // style: context.textTheme.headlineMedium?.withAdaptiveColor(
          //   context,
          //   lightColor: AppColors.colorNeutral900,
          //   darkColor: AppColors.colorNeutralDark900,
          // ),
        ),
      ),
    );
  }
}
