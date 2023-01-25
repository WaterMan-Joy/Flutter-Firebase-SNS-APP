import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_sns_app/core/common/loader.dart';
import 'package:flutter_firebase_sns_app/core/common/sign_in_button.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authControllerProvider 는 bool state 가 있다
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('SNS'),
      ),
      body: isLoading
          ? Loader()
          : Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('WELLCOME TO SNS APP'),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset('assets/images/google_2.jpeg'),
                    SizedBox(
                      height: 20,
                    ),
                    // TODO: google sign in click
                    SignInButton(),
                  ],
                ),
              ),
            ),
    );
  }
}
