import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'PostDetail.dart';
import 'LikeButton.dart';

class PostList extends StatelessWidget {
  final String type;

  PostList({required this.type});

  Stream<List<DocumentSnapshot>> getPostsByType(String type) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('type', isEqualTo: type)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Stream<int> getCommentCount(String postId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<int> getLikesCount(String postId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .snapshots()
        .map((snapshot) => (snapshot.data()?['likes']?.length ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DocumentSnapshot>>(
      stream: getPostsByType(type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('게시글이 없습니다.'));
        }

        final posts = snapshot.data!;
        return ListView.separated(
          itemCount: posts.length,
          separatorBuilder: (context, index) =>
              Divider(thickness: 2, color: Color(0XFFF2F3F5)),
          itemBuilder: (context, index) {
            final post = posts[index];
            final postId = post.id;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PostDetail(postId: postId, type: type),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      post['content'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        StreamBuilder<int>(
                          stream: getCommentCount(postId),
                          builder: (context, snapshot) {
                            final commentCount = snapshot.data ?? 0;
                            return Row(
                              children: [
                                Icon(Symbols.message_rounded,
                                    color: Color(0XFF4E5968)),
                                SizedBox(width: 4),
                                Text('$commentCount'),
                              ],
                            );
                          },
                        ),
                        LikeButton(postId: postId),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
