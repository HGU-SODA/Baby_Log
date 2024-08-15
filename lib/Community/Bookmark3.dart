// bookmark3.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LikeButton.dart';
import 'bookmark_service.dart';
import 'PostDetail.dart'; // PostDetail 임포트

class Bookmark3 extends StatelessWidget {
  final BookmarkService _bookmarkService = BookmarkService();

  Bookmark3({Key? key}) : super(key: key);

  Stream<DocumentSnapshot> getPostData(String postId) {
    return FirebaseFirestore.instance.collection('posts').doc(postId).snapshots();
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
    final userId = _bookmarkService.getCurrentUserId();

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '커뮤니티 북마크',
            style: TextStyle(
              color: Color(0XFFFFAB47),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "Pretendard Variable",
            ),
          ),
        ),
        body: Center(child: Text('Please log in to see your bookmarks')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
          title: Text(
            '커뮤니티 북마크',
            style: TextStyle(
              color: Color.fromRGBO(255, 171, 71, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "Pretendard Variable",
            ),
          ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var bookmarks = snapshot.data?.get('bookmark') ?? {};
          if (bookmarks.isEmpty) {
            return Center(child: Text('아직 북마크가 없습니다.'));
          }

          var bookmarkList = bookmarks.keys.toList();

          return ListView.builder(
            itemCount: bookmarkList.length,
            itemBuilder: (context, index) {
              String postId = bookmarkList[index];
              
              return StreamBuilder<DocumentSnapshot>(
                stream: getPostData(postId),
                builder: (context, postSnapshot) {
                  if (!postSnapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var postData = postSnapshot.data?.data() as Map<String, dynamic>?;

                  if (postData == null) {
                    return ListTile(title: Text('Post not found'));
                  }

                  bool hasImage = postData['imageUrl'] != null && postData['imageUrl'].isNotEmpty;
                  String authorId = postData['authorId'] ?? '';

                  return StreamBuilder<String>(
                    stream: getUserIcon(authorId),
                    builder: (context, iconSnapshot) {
                      String icon = iconSnapshot.data ?? 'default_icon';

                    if (hasImage) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetail(postId: postId, type: 'bookmark'),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 0.5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // 왼쪽 작은 사진
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    postData['imageUrl'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 22,
                                            height: 22,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFFFFBA69),
                                              shape: const OvalBorder(),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                _getIconAsset(icon),
                                                width: 12,
                                                height: 12,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              postData['authorNickname'] ?? '닉네임 없음',
                                              style: TextStyle(
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          LikeButton(postId: postId, log4: false, showCount: false),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        postData['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Inter",
                                          color: Colors.black,
                                        ),
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
                                              SizedBox(width: 4),
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
                                          SizedBox(width: 16),
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
                                              SizedBox(width: 4),
                                              StreamBuilder<int>(
                                                stream: getCommentCount(postId),
                                                builder: (context, snapshot) {
                                                  final commentsCount = snapshot.data ?? 0;
                                                  return Text(
                                                    '$commentsCount',
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
                        )
                      );
                    }
                    
                    else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetail(postId: postId, type: 'bookmark'),
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
                                postData['title'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                postData['content'] ?? '내용 없음',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 14),
                              Row(
                                children: [
                                  StreamBuilder<int>(
                                    stream: getCommentCount(postId),
                                    builder: (context, commentSnapshot) {
                                      final commentCount = commentSnapshot.data ?? 0;
                                      return Row(
                                        children: [
                                          Container(
                                            width: 22,
                                            height: 22,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFFFFBA69),
                                              shape: const OvalBorder(),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                _getIconAsset(icon),
                                                width: 12,
                                                height: 12,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(Icons.message_outlined, color: Color(0XFF4E5968)),
                                          SizedBox(width: 4),
                                          Text('$commentCount'),
                                          SizedBox(height: 8),
                                          LikeButton(postId: postId, log4: false),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          },
          );
        }
      ),
    );
  }
}