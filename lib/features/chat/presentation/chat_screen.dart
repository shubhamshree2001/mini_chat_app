import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_chat_ai_app/features/chat/cubit/chat_cubit.dart';
import 'package:mini_chat_ai_app/features/chat/data/model/chat_message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      jumpToBottom();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  bool isNearBottom() {
    if (!scrollController.hasClients) return true;

    return scrollController.offset >
        scrollController.position.maxScrollExtent - 100;
  }

  void jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!scrollController.hasClients) return;

      await Future.delayed(const Duration(milliseconds: 50));

      if (!scrollController.hasClients) return;

      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!scrollController.hasClients) return;

      await Future.delayed(const Duration(milliseconds: 50));

      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final ChatCubit chatCubit = context.read<ChatCubit>();
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (isNearBottom()) {
          scrollToBottom();
        }
      },
      builder: (context, state) {
        final List<ChatMessage> messages = state.allMessages;
        return Scaffold(
          appBar: AppBar(title: Text(chatCubit.state.selectedUser!.name)),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (_, i) {
                    final ChatMessage msg = messages[i];
                    final bool isSender = msg.owner == MessageOwner.sender;
                    return chatListViewItem(isSender, chatCubit, msg);
                  },
                ),
              ),
              chatTextField(context),
            ],
          ),
        );
      },
    );
  }

  Widget chatListViewItem(bool isSender, ChatCubit chatCubit, ChatMessage msg) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Receiver Avatar
          if (!isSender)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 14,
                child: Text(chatCubit.state.selectedUser!.initial),
              ),
            ),

          // Message Bubble
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 260),
                decoration: BoxDecoration(
                  color: isSender ? Colors.blue : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  msg.text,
                  style: TextStyle(
                    color: isSender ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                chatCubit.formatTime(msg.time),
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),

          // Sender Avatar
          if (isSender)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: CircleAvatar(
                radius: 14,
                child: Text("Y"),
              ),
            ),
        ],
      ),
    );
  }

  Widget chatTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          //color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Message",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  final text = controller.text.trim();
                  if (text.isEmpty) return;

                  context.read<ChatCubit>().sendMessage(text);
                  controller.clear();
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
