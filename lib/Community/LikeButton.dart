import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final String postId;
  final bool log4; // 자랑로그인지 아닌지
  final bool showCount; // 숫자를 표시할지 말지

  const LikeButton({required this.postId, required this.log4, this.showCount = true,});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
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
      final isLiked = userDoc.data()?['likedPosts']?.containsKey(widget.postId) ?? false;
      setState(() {
        _isFavorited = isLiked;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final postRef = FirebaseFirestore.instance.collection('posts').doc(widget.postId);

      try {
        if (_isFavorited) {
          await userRef.update({
            'likedPosts.${widget.postId}': FieldValue.delete(),
          });

          await postRef.update({
            'likes.${user.uid}': FieldValue.delete(),
          });
        } else {
          await userRef.update({
            'likedPosts.${widget.postId}': true,
          });

          await postRef.update({
            'likes.${user.uid}': true,
          });
        }

        setState(() {
          _isFavorited = !_isFavorited;
        });
      } catch (error) {
        print("Error updating favorite status: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .snapshots()
          .map((snapshot) => (snapshot.data()?['likes']?.length ?? 0)),
      builder: (context, snapshot) {
        final likesCount = snapshot.data ?? 0;

        final iconColor = widget.log4
            ? (_isFavorited ? Colors.red : Colors.black)
            : (_isFavorited ? Colors.red : Color(0XFF666667));

        final textColor = widget.log4 ? Colors.black : Color(0XFF666667);

        return Row(
          children: [
            IconButton(
              icon: Icon(
                _isFavorited ? Icons.favorite : Icons.favorite_border,
                color:  iconColor
              ),
              onPressed: _toggleFavorite,
            ),
            if (widget.showCount)
              Text(
                '$likesCount',
                style: TextStyle(color: textColor),
              ),
          ],
        );
      },
    );
  }
}