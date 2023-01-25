import 'package:flutter/material.dart';

// 파이어베이스 코어 초기화
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_sns_app/core/common/error.dart';
import 'package:flutter_firebase_sns_app/core/common/loader.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Flutter SNS APP',
              theme: Pallete.darkModeAppTheme,
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  return loggedInRoute;
                }
                return loggedOutRoute;
              }),
              routeInformationParser: RoutemasterParser(),
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => Loader());
  }
}
