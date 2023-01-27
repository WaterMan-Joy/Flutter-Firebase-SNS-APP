import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/core/common/error.dart';
import 'package:flutter_firebase_sns_app/core/common/loader.dart';
import 'package:flutter_firebase_sns_app/features/community/controller/community_controller.dart';
import 'package:flutter_firebase_sns_app/models/community_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push('/r/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('새로운 모임 만들기'),
              leading: Icon(Icons.post_add),
              onTap: () => navigateToCreateCommunity(context),
            ),
            ref.watch(userCommunitiesProvider).when(
                  data: (data) => Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        final community = data[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(community.avater),
                          ),
                          title: Text('${community.name}의 모임'),
                          trailing: Text('멤버 ${community.members.length}명'),
                          onTap: () => navigateToCommunity(context, community),
                        );
                      }),
                    ),
                  ),
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () => Loader(),
                ),
          ],
        ),
      ),
    );
  }
}
