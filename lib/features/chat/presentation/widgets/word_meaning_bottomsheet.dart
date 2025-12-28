import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_chat_ai_app/core/widgets/bottomsheets/bottomsheet_mainframe.dart';
import 'package:mini_chat_ai_app/features/chat/cubit/chat_cubit.dart';


class WordMeaningBottomSheet extends StatefulWidget {
  const WordMeaningBottomSheet({super.key});

  @override
  State<WordMeaningBottomSheet> createState() => _WordMeaningBottomSheetState();
}

class _WordMeaningBottomSheetState extends State<WordMeaningBottomSheet> {
  String getSheetTitle() {
    return "Word Meaning";
  }

  @override
  Widget build(BuildContext context) {
    final ChatCubit chatCubit = context.read<ChatCubit>();
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final String? wordMeaning = chatCubit.state.wordMeaning;
        return BottomSheetMainFrame(
          label: getSheetTitle(),
          initialChildSize: 0.2,
          minChildSize: 0.15,
          content: (scrollController) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(wordMeaning ?? ""),
              ],
            );
          },
        );
      },
    );
  }
}
