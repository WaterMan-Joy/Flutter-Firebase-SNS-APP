import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends ConsumerWidget {
  final String name;
  const ModToolsScreen({super.key, required this.name});

  void navigateToEditScreen(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('아바타'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('수정'),
            onTap: () => navigateToEditScreen(context),
          ),
          ListTile(
            leading: Icon(Icons.add_moderator),
            title: Text('멤버보기'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('설정'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
