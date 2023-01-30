// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/core/utils.dart';
import 'package:flutter_firebase_sns_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) {
  return null;
});

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(
      // watch 로 항상 주시한다
      authRepository: ref.watch(authRepositoryProvider),
      ref: ref,
    );
  },
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

// bool type 스테이트 생성
class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);
  // state = false

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  // BuildContext 를 받는 이유는 실패 시 스낵바를 사용하기 때문
  void signInWithGoogle(BuildContext context) async {
    // 로그인 시도 했을때 로딩 바 실행
    state = true;
    final user = await _authRepository.signInWithGoogle();
    // 로그인 시도 완료 후 로딩바 false
    state = false;
    // l은 실패했을때, r or userModel 은 성공 했을때
    user.fold(
        (l) => showSnackBar(context, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  void logOut() {
    _authRepository.logOut();
  }

  // repository 와 controller 를 분리
  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
