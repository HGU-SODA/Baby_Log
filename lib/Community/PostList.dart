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

  Stream<String> getUserIcon(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => snapshot.data()?['status'] ?? '');
  }

  String _getIconAsset(String icon) {
    switch (icon) {
      case '둘러볼게요':
        return 'assets/sun.png';
      case '임신 중이에요':
        return 'assets/leaf.png';
      case '아기를 키우고 있어요':
        return 'assets/sprout.png';
      default:
        return 'assets/default_icon.png';
    }
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

        if (type == '자랑로그') {
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3/4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final postId = post.id;
              final userId = post['authorId'];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetail( postId: postId, type: type),
                    ),
                  );
                },
                child: Card(
                  elevation: 0.8,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: post['imageUrl'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                child: Image.network(
                                  post['imageUrl'],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: Center(child: Text('이미지 없음')),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                StreamBuilder<String>(
                                  stream: getUserIcon(userId),
                                  builder: (context, snapshot) {
                                    final userIcon = snapshot.data ?? '';
                                    return Container(
                                      width: 22,
                                      height: 22,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFFFBA69),
                                        shape: const OvalBorder(),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          _getIconAsset(userIcon),
                                          width: 12,
                                          height: 12,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 6),
                                Text(
                                  post['authorNickname'] ?? '닉네임 없음',
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                LikeButton(postId: postId, log4: false, showCount: false),
                              ],
                            ),
                            Text(
                              post['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: "Inter",
                                color: Colors.black),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '좋아요 ', 
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Color(0XFF74828D),
                                      ),
                                    ),
                                    StreamBuilder<int>(
                                      stream: getLikesCount(postId),
                                      builder: (context, snapshot) {
                                        final likesCount = snapshot.data ?? 0;
                                        return Text(
                                          '$likesCount',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0XFF74828D),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5),
                                Row(
                                  children: [
                                    Text(
                                      '댓글 ', 
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Color(0XFF74828D),
                                      ),
                                    ),
                                    StreamBuilder<int>(
                                      stream: getCommentCount(postId),
                                      builder: (context, snapshot) {
                                        final commentCount = snapshot.data ?? 0;
                                        return Text(
                                          '$commentCount',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0XFF74828D),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        else {
          return ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (context, index) =>
                Divider(thickness: 2, color: Color(0XFFF2F3F5)),
            itemBuilder: (context, index) {
              final post = posts[index];
              final postId = post.id;
              final userId = post['authorId'];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetail(postId: postId, type: type),
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
                          StreamBuilder<String>(
                            stream: getUserIcon(userId),
                            builder: (context, snapshot) {
                              final userIcon = snapshot.data ?? '';
                              return Container(
                                width: 22,
                                height: 22,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFBA69),
                                  shape: const OvalBorder(),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    _getIconAsset(userIcon),
                                    width: 12,
                                    height: 12,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 14),
                          StreamBuilder<int>(
                            stream: getCommentCount(postId),
                            builder: (context, snapshot) {
                              final commentCount = snapshot.data ?? 0;
                              return Row(
                                children: [
                                  Icon(Symbols.message_rounded, color: Color(0XFF4E5968)),
                                  SizedBox(width: 4),
                                  Text('$commentCount'),
                                ],
                              );
                            },
                          ),
                          LikeButton(postId: postId, log4: false),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
