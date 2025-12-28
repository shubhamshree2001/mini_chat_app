import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_chat_ai_app/core/cache/chats_cache_manager.dart';
import 'package:mini_chat_ai_app/core/navigation/app_routes.dart';
import 'package:mini_chat_ai_app/features/chat/cubit/chat_cubit.dart';
import 'package:mini_chat_ai_app/features/home/cubit/home_cubit.dart';
import 'package:mini_chat_ai_app/features/home/data/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _showTabs = true;
  int _currentTab = 0;
  bool _isTabChanging = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _isTabChanging = true;
        return;
      }

      // Tab switch finished
      _currentTab = _tabController.index;
      _isTabChanging = false;

      // Restore correct tab visibility based on scroll position
      _syncTabBarVisibility();
    });
  }

  void _syncTabBarVisibility() {
    final controller = _currentTab == 0 ? usersScroll : historyScroll;

    if (!controller.hasClients) return;

    final offset = controller.offset;

    if (offset <= 0) {
      setState(() => _showTabs = true);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final ScrollController usersScroll = ScrollController();
  final ScrollController historyScroll = ScrollController();


  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final ChatCubit chatCubit = context.read<ChatCubit>();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.userAddedMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.userAddedMessage!)));
          context.read<HomeCubit>().clearMessage();
        }
      },
      builder: (context, state) {
        final List<UserModel> users = homeCubit.state.allUsers;
        final List<UserModel> chatHistoryUsers =
            homeCubit.state.chatHistoryUsers;
        return Scaffold(
          floatingActionButton: _currentTab == 0
              ? FloatingActionButton(
                  onPressed: addUser,
                  child: const Icon(Icons.add),
                )
              : null,
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (_isTabChanging) return false;
              if (notification is UserScrollNotification &&
                  notification.metrics.axis == Axis.vertical) {
                if (notification.direction == ScrollDirection.reverse) {
                  if (_showTabs) setState(() => _showTabs = false);
                } else if (notification.direction == ScrollDirection.forward) {
                  if (!_showTabs) setState(() => _showTabs = true);
                }
              }
              return false;
            },
            child: NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  centerTitle: true,
                  pinned: false,
                  elevation: 0,
                  title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -0.2),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: _showTabs
                        ? KeyedSubtree(
                            key: const ValueKey('tabs'),
                            child: tabSelectionButtonView(),
                          )
                        : const SizedBox(key: ValueKey('empty')),
                  ),
                ),
              ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  // USERS TAB
                  ListView.builder(
                    controller: usersScroll,
                    itemCount: users.length,
                    itemBuilder: (_, i) {
                      final user = users[i];
                      return ListTile(
                        leading: Stack(
                          children: [
                            CircleAvatar(child: Text(user.initial)),
                            if (user.isOnline)
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.green,
                                ),
                              ),
                          ],
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.statusText),
                        onTap: () {
                          chatCubit.loadChat(user);
                          Navigator.pushNamed(context, Routes.chatScreen);
                        },
                      );
                    },
                  ),

                  // CHAT HISTORY TAB
                  if (chatHistoryUsers.isEmpty) ...[
                    const Center(
                      child: Text(
                        "No chats yet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ] else ...[
                    ListView.builder(
                      controller: historyScroll,
                      itemCount: chatHistoryUsers.length,
                      itemBuilder: (_, i) {
                        final user = chatHistoryUsers[i];
                        final chats = ChatCacheManager.loadChatsForUser(
                          user.id,
                        );
                        final last = chats.last;

                        return ListTile(
                          leading: CircleAvatar(child: Text(user.initial)),
                          title: Text(user.name),
                          subtitle: Text(
                            last.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            "${DateTime.now().difference(last.time).inMinutes} min ago",
                            style: const TextStyle(fontSize: 12),
                          ),
                          onTap: () {
                            chatCubit.loadChat(user);
                            Navigator.pushNamed(context, Routes.chatScreen);
                          },
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addUser() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add User"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Enter name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<HomeCubit>().addUser(controller.text);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget tabSelectionButtonView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          indicator: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.deepPurpleAccent.withOpacity(0.4),
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          tabs: [buildTab('Users'), buildTab('Chat History')],
        ),
      ),
    );
  }

  Widget buildTab(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
        ),
      ],
    );
  }
}
