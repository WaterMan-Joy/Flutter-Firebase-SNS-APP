import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_firebase_sns_app/features/home/drawers/community_list_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void getDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void navigateToCreateCommuniry(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // user data
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.name),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => getDrawer(context),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FadeInImage.assetNetwork(
                placeholder: 'assets/images/google_2.jpeg', image: user.banner),
          ],
        ),
      ),
      drawer: CommunityListDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToCreateCommuniry(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
