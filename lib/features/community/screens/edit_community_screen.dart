import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/core/common/error.dart';
import 'package:flutter_firebase_sns_app/core/common/loader.dart';
import 'package:flutter_firebase_sns_app/core/constants/constants.dart';
import 'package:flutter_firebase_sns_app/features/community/controller/community_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
        data: (community) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('수정'),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text('저장'),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: DottedBorder(
                    radius: Radius.circular(30),
                    dashPattern: [10, 4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: community.bannder.isEmpty ||
                              community.bannder == Constants.bannerDefault
                          ? Center(
                              child: Icon(Icons.camera_alt),
                            )
                          : Image.network(community.bannder),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, StackTrace) => ErrorText(error: error.toString()),
        loading: () => Loader());
  }
}
