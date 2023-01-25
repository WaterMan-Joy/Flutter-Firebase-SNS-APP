import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(user?.name ?? ''),
          actions: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/google_2.jpeg',
              image: user?.profilePic ?? '',
              width: 40,
              fit: BoxFit.contain,
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              FadeInImage.assetNetwork(
                  placeholder: 'assets/images/google_2.jpeg',
                  image: user?.banner ?? ''),
            ],
          ),
        ));
  }
}
