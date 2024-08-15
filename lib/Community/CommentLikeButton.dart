import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentLikeButton extends StatefulWidget {
  final String postId;
  final String commentId;

  const CommentLikeButton({
    required this.postId,
    required this.commentId,
  });

  @override
  _CommentLikeButtonState createState() => _CommentLikeButtonState();
}

class _CommentLikeButtonState extends State<CommentLikeButton> {
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _initializeFavoriteStatus();
  }

  Future<void> _initializeFavoriteStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final isLiked = userDoc.data()?['likedComments']?.containsKey(widget.commentId) ?? false;
      setState(() {
        _isFavorited = isLiked;
      });
    }
  }

  Future<void> toggleFavorite(String postId, String commentId, bool isFavorited) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final commentRef = FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc(commentId);
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final commentSnapshot = await transaction.get(commentRef);
      final userSnapshot = await transaction.get(userRef);

      if (!commentSnapshot.exists || !userSnapshot.exists) {
        throw Exception("Comment or User does not exist!");
      }

      final currentLikesCount = commentSnapshot.data()?['likesCount'] ?? 0;
      final likedComments = userSnapshot.data()?['likedComments'] ?? {};

      if (isFavorited) {
        // 유저 문서에 좋아요 추가
        likedComments[commentId] = true;
        await transaction.update(userRef, {'likedComments': likedComments});
        // 댓글 문서에 좋아요 수 증가
        await transaction.update(commentRef, {'likesCount': currentLikesCount + 1});
      } else {
        // 유저 문서에서 좋아요 제거
        likedComments.remove(commentId);
        await transaction.update(userRef, {'likedComments': likedComments});
        // 댓글 문서에 좋아요 수 감소
        await transaction.update(commentRef, {'likesCount': currentLikesCount - 1});
      }
    }).catchError((error) {
      print("Error updating favorite: $error");
    });
  }

  Stream<bool> isCommentFavoritedByUser(String commentId) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
          final likedComments = snapshot.data()?['likedComments'] ?? {};
          return likedComments.containsKey(commentId) && likedComments[commentId] == true;
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .doc(widget.commentId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final commentData = snapshot.data?.data() as Map<String, dynamic>?;
        final likesCount = commentData?['likesCount'] ?? 0;

        return Row(
          children: [
            IconButton(
              icon: Icon(
                _isFavorited ? Icons.thumb_up : Icons.thumb_up_outlined,
                color: Color(0XFF4E5968),
              ),
              onPressed: () async {
                await toggleFavorite(widget.postId, widget.commentId, !_isFavorited);
                setState(() {
                  _isFavorited = !_isFavorited;
                });
              },
            ),
            Text('$likesCount'),
          ],
        );
      },
    );
  }
}
