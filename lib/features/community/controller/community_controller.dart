// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/core/constants/constants.dart';
import 'package:flutter_firebase_sns_app/core/utils.dart';
import 'package:flutter_firebase_sns_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_firebase_sns_app/features/community/repository/community_repository.dart';
import 'package:flutter_firebase_sns_app/models/community_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../../../core/providers/stoage_repository_providers.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

final userCommunitiesProvider = StreamProvider((ref) {
  final communityProvider = ref.watch(communityControllerProvider.notifier);
  return communityProvider.getUserCommunities();
});

// StreamProviderFamily 는 다른 파라미터를 받을 때 사용한다
final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(communityControllerProvider.notifier)
      .getCommunityByName(name);
  // final communityProvider = ref.watch(communityControllerProvider.notifier);
  // return communityProvider.getCommunityByName(name);
});

// screen view 에서 isLoading 으로 왓치 한다
final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);

  return CommunityController(
      communityRepository: communityRepository,
      storageRepository: storageRepository,
      ref: ref);
});

// StateNotifier<bool> 인 이유는 로딩바를 적용하려고
class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  CommunityController({
    required communityRepository,
    required storageRepository,
    required ref,
  })  : _communityRepository = communityRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  // TODO: Create Community
  // BuildContext 를 받는 이유는 오류 발생 시 스낵바를 사용하기 때문
  void createCommunity(String name, BuildContext context) async {
    // 로딩바 실행
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    Community community = Community(
      id: name,
      name: name,
      banner: Constants.bannerDefault,
      avatar: Constants.avatarDefault,
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

  // TODO: Edit Community
  void editCommunity({
    required File? profileFile,
    required File? bannerFile,
    // required Uint8List? profileWebFile,
    // required Uint8List? bannerWebFile,
    required BuildContext context,
    required Community community,
  }) async {
    state = true;
    if (profileFile != null) {
      // communities/profile/memes
      final res = await _storageRepository.storeFile(
        path: 'communities/profile',
        id: community.name,
        file: profileFile,
        // webFile: profileWebFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => community = community.copyWith(avatar: r),
      );
    }

    if (bannerFile != null) {
      // communities/banner/memes
      final res = await _storageRepository.storeFile(
        path: 'communities/banner',
        id: community.name,
        file: bannerFile,
        // webFile: bannerWebFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => community = community.copyWith(banner: r),
      );
    }

    final res = await _communityRepository.editCommunity(community);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Routemaster.of(context).pop(),
    );
  }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)?.uid ?? '';
    return _communityRepository.getUserCommunities(uid);
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name);
  }
}
