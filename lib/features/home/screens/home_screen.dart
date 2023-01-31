import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_firebase_sns_app/features/home/delegates/search_community_delegate.dart';
import 'package:flutter_firebase_sns_app/features/home/drawers/community_list_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../theme/pallete.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.name),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: Icon(Icons.search),
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
              onPressed: () => displayEndDrawer(context),
            );
          }),
        ],
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
      drawer: CommunityListDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

// final user = ref.watch(userProvider)!;
//     final isGuest = !user.isAuthenticated;
//     final currentTheme = ref.watch(themeNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(user.name),
//         leading: Builder(builder: (context) {
//           return IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () => displayDrawer(context),
//           );
//         }),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.search),
//           ),
//           Builder(builder: (context) {
//             return IconButton(
//               icon: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profilePic),
//               ),
//               onPressed: () => displayEndDrawer(context),
//             );
//           }),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           children: [],
//         ),
//       ),
//       drawer: CommunityListDrawer(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => navigateToCreateCommuniry(context),
//         child: Icon(Icons.add),
//       ),
//     );
