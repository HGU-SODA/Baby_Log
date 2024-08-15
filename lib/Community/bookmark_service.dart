import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookmarkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 현재 사용자 ID 가져오기
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  // 북마크 상태 불러오기
  Future<bool> getBookmarkStatus(String userId, String postId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    final bookmarks = userDoc.data()?['bookmark'] ?? {};
    return bookmarks[postId] == true;
  }

  // 북마크 상태 토글
  Future<void> toggleBookmark(String userId, String postId) async {
    final userDoc = _firestore.collection('users').doc(userId);
    final docSnapshot = await userDoc.get();
    final currentBookmarks = docSnapshot.data()?['bookmark'] ?? {};

    if (currentBookmarks.containsKey(postId) && currentBookmarks[postId] == true) {
      await userDoc.update({
        'bookmark.$postId': FieldValue.delete(),
      });
    } else {
      await userDoc.update({
        'bookmark.$postId': true,
      });
    }
  }
}
