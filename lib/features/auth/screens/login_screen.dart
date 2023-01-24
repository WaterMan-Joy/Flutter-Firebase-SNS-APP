import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_sns_app/core/common/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SNS'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('WELLCOME TO SNS APP'),
              SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/google_2.jpeg'),
              SizedBox(
                height: 20,
              ),
              SignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
