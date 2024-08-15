import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> toggleFavorite(String postId, bool isFavorited) async {
  final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final postSnapshot = await transaction.get(postRef);
    final userSnapshot = await transaction.get(userRef);

    if (!postSnapshot.exists || !userSnapshot.exists) {
      throw Exception("Post or User does not exist!");
    }

    final currentLikesCount = postSnapshot.data()?['likesCount'] ?? 0;
    final likedPosts = userSnapshot.data()?['likedPosts'] ?? {};

    if (isFavorited) {
      // 유저 문서에 좋아요 추가
      likedPosts[postId] = true;
      await transaction.update(userRef, {'likedPosts': likedPosts});
      // 게시글 문서에 좋아요 수 증가
      await transaction.update(postRef, {'likesCount': currentLikesCount + 1});
    } else {
      // 유저 문서에서 좋아요 제거
      likedPosts.remove(postId);
      await transaction.update(userRef, {'likedPosts': likedPosts});
      // 게시글 문서에 좋아요 수 감소
      await transaction.update(postRef, {'likesCount': currentLikesCount - 1});
    }
  }).catchError((error) {
    print("Error updating favorite: $error");
  });
}

Stream<bool> isPostFavoritedByUser(String postId) {
  final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots()
      .map((snapshot) {
        final likedPosts = snapshot.data()?['likedPosts'] ?? {};
        return likedPosts.containsKey(postId) && likedPosts[postId] == true;
      });
}

Stream<List<DocumentSnapshot>> getPostsByType(String type) {
  return FirebaseFirestore.instance
      .collection('posts')
      .where('type', isEqualTo: type)
      .snapshots()
      .map((snapshot) => snapshot.docs);
}
