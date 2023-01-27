import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/core/common/loader.dart';
import 'package:flutter_firebase_sns_app/features/community/controller/community_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  TextEditingController communityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    communityController.dispose();
  }

  void createCommunity() {
    // why use notifier? 내 추측에는 마지막에 notifier 를 사용하는 것 같음
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(communityController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    // features/community/controller/
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('작성하기'),
        actions: [
          TextButton(
            onPressed: createCommunity,
            child: Text('완료'),
          ),
        ],
      ),
      body: isLoading
          ? Loader()
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text('글 작성하기')),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: communityController,
                    decoration: InputDecoration(
                      hintText: '힌트',
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),
                    maxLength: 21,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: createCommunity,
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
