import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'LikeButton.dart';
import 'CommentLikeButton.dart';

class PostDetail extends StatefulWidget {
  final String postId;
  final String type;

  const PostDetail({Key? key, required this.postId, required this.type})
      : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // 게시물 작성자의 ID
  Future<String> _getPostAuthorId() async {
    final postDoc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .get();
    return postDoc.data()?['authorId'] ?? '';
  }

  // 게시물 작성자의 닉네임
  Future<String> _getPostAuthorNickname(String postAuthorId) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(postAuthorId)
        .get();
    if (userDoc.exists) {
      return userDoc.data()?['nickName'] ?? '닉네임 없음';
    }
    return '닉네임 없음';
  }

  // 현재 사용자의 ID
  Future<String> _getCurrentUserId() async {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  // 현재 사용자의 닉네임
  Future<String> _getCurrentUserNickname() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc.data()?['nickName'] ?? '닉네임 없음';
      }
    }
    return '닉네임 없음';
  }

  Future<void> _addComment() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final currentUserNickname = await _getCurrentUserNickname();
      final commentContent = _commentController.text;

      if (commentContent.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .collection('comments')
            .add({
          'authorId': user.uid,
          'authorNickname': currentUserNickname,
          'content': commentContent,
          'createdAt': Timestamp.now(),
          'likes': {},
        });

        _commentController.clear();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }
  }

  // 댓글 옵션 (수정, 삭제, 신고 등)을 표시하는 함수
  Future<void> _showCommentOptions(
      String commentId, String commentAuthorId) async {
    final currentUserId = await _getCurrentUserId();
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentUserId == commentAuthorId)
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('수정'),
              onTap: () {
                Navigator.pop(context);
                // 댓글 수정
              },
            ),
          if (currentUserId == commentAuthorId)
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('삭제'),
              onTap: () {
                Navigator.pop(context);
                // 댓글 삭제
              },
            ),
          if (currentUserId != commentAuthorId)
            ListTile(
              leading: Icon(CupertinoIcons.flag),
              title: Text('신고'),
              onTap: () {
                Navigator.pop(context);
                // 댓글 신고
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, 'fromPostDetailScreen');
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0XFF1C1B1F)),
        ),
        centerTitle: true,
        title: Text(
          '${widget.type}',
          style: TextStyle(
            color: Color(0XFFFFAB47),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: "Pretendard Variable",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final post = snapshot.data!;
          final title = post['title'];
          final content = post['content'];
          final createdAt = post['createdAt']?.toDate() ?? DateTime.now();
          final formattedDate =
              DateFormat('yyyy.MM.dd. HH:mm').format(createdAt);

          return FutureBuilder<String>(
            future: _getPostAuthorId(),
            builder: (context, authorSnapshot) {
              if (!authorSnapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final postAuthorId = authorSnapshot.data!;
              final currentUserId = FirebaseAuth.instance.currentUser?.uid;

              return FutureBuilder<String>(
                future: _getPostAuthorNickname(postAuthorId),
                builder: (context, nicknameSnapshot) {
                  if (!nicknameSnapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final postAuthorNickname = nicknameSnapshot.data!;

                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(thickness: 2, color: Color(0XFFF2F3F5)),
                          SizedBox(height: 10),
                          Container(
                            height: 95,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Inter",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                          size: 24,
                                          color: Color(0XFF666667),
                                          CupertinoIcons.ellipsis_vertical),
                                      onPressed: () {
                                        if (currentUserId == postAuthorId) {
                                          // 현재 유저가 게시물 작성자인 경우
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading: Icon(Icons.edit),
                                                  title: Text('수정'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    // 게시물 수정
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.delete),
                                                  title: Text('삭제'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    // 게시물 삭제
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading:
                                                      Icon(CupertinoIcons.flag),
                                                  title: Text('신고'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    // 게시물 신고
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    postAuthorNickname,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Inter",
                                      color: Color(0XFF2D2D2D),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formattedDate,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Pretendard Variable",
                                      color: Color(0XFF8994A4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 2, color: Color(0XFFF2F3F5)),
                          Container(
                            constraints: BoxConstraints(minHeight: 200),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, bottom: 8.0),
                                  child: Text(
                                    content,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Pretendard Variable",
                                      color: Color(0XFF2D2D2D),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      LikeButton(postId: widget.postId),
                                      SizedBox(width: 8),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('posts')
                                            .doc(widget.postId)
                                            .collection('comments')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                      CupertinoIcons
                                                          .chat_bubble_2,
                                                      color: Color(0XFF666667)),
                                                  onPressed: () {},
                                                ),
                                                Text(
                                                  '0',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        "Pretendard Variable",
                                                    color: Color(0XFF666667),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          final commentCount =
                                              snapshot.data!.docs.length;
                                          return Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                    CupertinoIcons
                                                        .chat_bubble_2,
                                                    color: Color(0XFF666667)),
                                                onPressed: () {},
                                              ),
                                              Text(
                                                '댓글 $commentCount',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      "Pretendard Variable",
                                                  color: Color(0XFF666667),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.bookmark_outline,
                                            color: Color(0XFF666667)),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 2, color: Color(0XFFF2F3F5)),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .doc(widget.postId)
                                .collection('comments')
                                .orderBy('createdAt', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              final comments = snapshot.data!.docs;

                              return Column(
                                children: comments.map((comment) {
                                  final commentData =
                                      comment.data() as Map<String, dynamic>;
                                  final commentId = comment.id;
                                  final commentAuthorId =
                                      commentData['authorId'];
                                  final content = commentData['content'];
                                  final createdAt =
                                      commentData['createdAt']?.toDate();
                                  final DateFormat dateFormat =
                                      DateFormat('MM.dd. HH:mm');
                                  final formattedDate = dateFormat
                                      .format(createdAt ?? DateTime.now());

                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              commentData['authorNickname'],
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0XFF2D2D2D),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                            Spacer(),
                                            CommentLikeButton(
                                                postId: widget.postId,
                                                commentId: commentId),
                                            IconButton(
                                              iconSize: 19,
                                              color: Color(0XFF4E5968),
                                              icon: Icon(CupertinoIcons
                                                  .ellipsis_vertical),
                                              onPressed: () {
                                                _showCommentOptions(
                                                    commentId, commentAuthorId);
                                              },
                                            ),
                                          ],
                                        ),
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0XFF8994A4),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Pretendard Variable",
                                          ),
                                        ),
                                        Text(
                                          content,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Pretendard Variable",
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color(0XFFF2F3F5),
                  ),
                  child: TextField(
                    controller: _commentController,
                    cursorColor: Color(0XFFFF9C27),
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요.',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Pretendard Variable",
                        color: Color(0XFF4E5968),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          size: 30,
                          color: Color(0XFF4E5968),
                        ),
                        onPressed: _addComment,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
