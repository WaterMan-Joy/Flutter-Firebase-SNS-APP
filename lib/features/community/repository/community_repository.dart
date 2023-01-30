// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_sns_app/core/constants/constants.dart';
import 'package:flutter_firebase_sns_app/core/constants/firebase_constants.dart';
import 'package:flutter_firebase_sns_app/core/failure.dart';
import 'package:flutter_firebase_sns_app/core/providers/firebase_providers.dart';
import 'package:flutter_firebase_sns_app/core/type_defs.dart';
import 'package:flutter_firebase_sns_app/models/community_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

// 컨트롤러에서 communityControllerProvier 에서 커뮤니티레파지토리프로바이더를 왓치 한다
final communityRepositoryProvider = Provider((ref) {
  // 커뮤니티레파지토리는 파이어베이스파이어스토어를 왓치한다
  return CommunityRepository(
      firebaseFirestore: ref.watch(firebaseFirestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firebaseFirestore;
  CommunityRepository({
    required firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  FutureVoid createCommunity(Community community) async {
    try {
      // Why var?
      var communityDoc = await _communites.doc(community.name).get();
      if (communityDoc.exists) {
        throw '커뮤니티 존재함';
      }
      return right(_communites.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw left(Failure(e.toString()));
    }
  }

  // 커뮤니티 리스트
  Stream<List<Community>> getUserCommunities(String uid) {
    return _communites
        .where('members', arrayContains: uid)
        .snapshots()
        .map((event) {
      // List<Community> 타입으로 리턴해야 하기 때문에 먼저 빈 배열을 만든다. 추 후에 add
      List<Community> communities = [];
      // map 으로 event.docs List 를 doc 에다 넣고 doc 데이타를 formMap으로 감싸아준다
      for (var doc in event.docs) {
        // formMap 으로 감싸서 빈 배열에 add 한다
        communities.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }
      // List<Community> 타입으로 만들어 리턴한다
      return communities;
    });
  }

  FutureVoid editCommunity(Community community) async {
    try {
      return right(_communites.doc(community.name).update(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<Community> getCommunityByName(String name) {
    return _communites.doc(name).snapshots().map(
        (event) => Community.fromMap(event.data() as Map<String, dynamic>));
  }

  CollectionReference get _communites =>
      _firebaseFirestore.collection(FirebaseConstants.communitiesCollection);
}
