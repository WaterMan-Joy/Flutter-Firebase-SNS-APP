import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 파이어베이스 코어 초기화
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_sns_app/core/common/error.dart';
import 'package:flutter_firebase_sns_app/core/common/loader.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_firebase_sns_app/models/user_model.dart';
import 'package:flutter_firebase_sns_app/router.dart';
import 'package:flutter_firebase_sns_app/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'features/auth/screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getUserData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Flutter SNS APP',
              theme: Pallete.lightModeAppTheme,
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  getUserData(ref, data);
                  if (userModel != null) {
                    return loggedInRoute;
                  }
                }
                return loggedOutRoute;
              }),
              routeInformationParser: RoutemasterParser(),
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => Loader());
  }
}
