// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/core/common/error.dart';
import 'package:flutter_firebase_sns_app/core/common/loader.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_firebase_sns_app/features/community/controller/community_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({
    super.key,
    required this.name,
  });

  void navigateToModToolsScreen(BuildContext context) {
    Routemaster.of(context).push('/mod-tools/$name');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 멤버 탈퇴 혹은 멤버 가입 용도 왓치
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
          data: (community) {
            return NestedScrollView(
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 150,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            community.bannder,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(community.avater),
                              radius: 35,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${community.name} 의 모임',
                                style: TextStyle(fontSize: 30),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(),
                              community.mods.contains(user.uid)
                                  ? ElevatedButton(
                                      onPressed: () =>
                                          navigateToModToolsScreen(context),
                                      child: Text('설정'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                          community.mods.contains(user.uid)
                                              ? '가입완료'
                                              : '가입하기'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          Text(
                            '${community.members.length}명',
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              }),
              body: Center(),
            );
          },
          error: (error, StackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader()),
    );
  }
}
