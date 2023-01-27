// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/core/constants/constants.dart';
import 'package:flutter_firebase_sns_app/core/utils.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_firebase_sns_app/features/community/repository/community_repository.dart';
import 'package:flutter_firebase_sns_app/models/community_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final userCommunitiesProvider = StreamProvider((ref) {
  final communityProvider = ref.watch(communityControllerProvider.notifier);
  return communityProvider.getUserCommunities();
});

// screen view 에서 isLoading 으로 왓치 한다
final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  return CommunityController(
      communityRepository: communityRepository, ref: ref);
});

// StateNotifier<bool> 인 이유는 로딩바를 적용하려고
class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  CommunityController({
    required communityRepository,
    required ref,
  })  : _communityRepository = communityRepository,
        _ref = ref,
        super(false);

  // BuildContext 를 받는 이유는 오류 발생 시 스낵바를 사용하기 때문
  void createCommunity(String name, BuildContext context) async {
    // 로딩바 실행
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    Community community = Community(
      id: name,
      name: name,
      bannder: Constants.bannerDefault,
      avater: Constants.avatarDefault,
      members: [uid],
      mods: [uid],
    );
    final res = await _communityRepository.createCommunity(community);
    // loading bar finish
    state = false;
    res.fold((l) {
      // 실패
      showSnackBar(context, l.message);
    }, (r) {
      // 성공
      showSnackBar(context, '성공');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)?.uid ?? '';
    return _communityRepository.getUserCommunities(uid);
  }
}
