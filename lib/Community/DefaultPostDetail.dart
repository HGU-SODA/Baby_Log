import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'CommentSection.dart';
import 'EditCommentForm.dart';
import 'EditForm.dart';
import 'LikeButton.dart';

class DefaultPostDetail extends StatefulWidget {
  final String postId;
  final String type;
  final TextEditingController commentController;
  final ScrollController scrollController;
  final bool isSaved;
  final VoidCallback onToggleBookmark;
  final Future<String> Function() getCurrentUserNickname;
  final Future<String> Function(String) getPostAuthorNickname;
  final Future<String> Function() getPostAuthorId;
  final Future<DocumentSnapshot> Function() getPost;
  final void Function(String formType, {String? initialContent, String? commentId}) onEdit;

  const DefaultPostDetail({
    Key? key,
    required this.postId,
    required this.type,
    required this.commentController,
    required this.scrollController,
    required this.isSaved,
    required this.onToggleBookmark,
    required this.getCurrentUserNickname,
    required this.getPostAuthorNickname,
    required this.getPostAuthorId,
    required this.getPost,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<DefaultPostDetail> createState() => _DefaultPostDetailState();
}

class _DefaultPostDetailState extends State<DefaultPostDetail> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  bool _isEditing = false;
  String _editType = 'post';

  void _loadInitialContent() async {
    final post = await widget.getPost();
    final postData = post.data() as Map<String, dynamic>;
    _titleController.text = postData['title'] ?? '';
    _contentController.text = postData['content'] ?? '';
  }

  void _startEditing(String formType, {String? commentId}) {
    setState(() {
      _isEditing = true;
      _editType = formType;
    });
    if (formType == 'post') {
      // 게시물 편집을 위해 새 화면으로 이동
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditForm(
            titleController: _titleController,
            contentController: _contentController,
            onSave: _savePost,
            formType: 'post',
          ),
        ),
      );
    } else if (formType == 'comment') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditCommentForm(
            commentController: widget.commentController,
            commentId: commentId ?? '',
            postId: widget.postId,
            formType: 'comment',
            onSave: () async {
              await _saveComment();
              setState(() {
                _isEditing = false;
              });
            },
          ),
        ),
      );
    }
  }

  Future<void> _savePost() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 상태가 아닙니다.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('posts').add({
        'title': _titleController.text,
        'content': _contentController.text,
        'authorId': user.uid,
        'authorNickname': user.displayName ?? 'Anonymous', // Optional: 사용자 닉네임
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post saved successfully!')),
      );

      Navigator.of(context).pop(); // 현재 페이지 닫기

    } catch (e) {
      print('Failed to save post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save post: $e')),
      );
    }
  }
  
  Future<void> _saveComment() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 상태가 아닙니다.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .add({
          'content': _commentController.text,
          'authorId': user.uid,
          'authorNickname': user.displayName ?? 'Anonymous', // Optional: 사용자 닉네임
          'createdAt': FieldValue.serverTimestamp(),
        });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment saved successfully!')),
      );
      
      Navigator.of(context).pop();  // 댓글 저장 후 페이지 닫기

    } catch (e) {
      print('Failed to save comment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save comment: $e')),
      );
    }
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
        return 'assets/default_icon.png'; // 기본 아이콘
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.getPost(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        
        final post = snapshot.data!;
        final title = post['title'];
        final content = post['content'];
        final createdAt = post['createdAt']?.toDate() ?? DateTime.now();
        final formattedDate = DateFormat('yyyy.MM.dd. HH:mm').format(createdAt);

        return FutureBuilder<String>(
          future: widget.getPostAuthorId(),
          builder: (context, authorSnapshot) {
            if (!authorSnapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final postAuthorId = authorSnapshot.data!;
            final currentUserId = FirebaseAuth.instance.currentUser?.uid;
            final userId = post['authorId'];

            return FutureBuilder<String>(
              future: widget.getPostAuthorNickname(postAuthorId),
              builder: (context, nicknameSnapshot) {
                if (!nicknameSnapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final postAuthorNickname = nicknameSnapshot.data!;

                return SingleChildScrollView(
                  controller: widget.scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.type != '자랑로그') Divider(thickness: 2, color: Color(0XFFF2F3F5)),
                        SizedBox(height: 10),
                        Container(
                          height: 95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.type != '자랑로그') 
                                    Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Inter",
                                        color: Colors.black,
                                      ),
                                    ),
                                  if (widget.type == '자랑로그') 
                                    Row(
                                      children: [
                                        StreamBuilder<String>(
                                          stream: getUserIcon(userId),
                                          builder: (context, snapshot) {
                                            final userIcon = snapshot.data ?? '';
                                            return Container(
                                              width: 24,
                                              height: 24,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFFFBA69),
                                                shape: const OvalBorder(),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  _getIconAsset(userIcon),
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          postAuthorNickname,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Inter",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  Spacer(),
                                  PopupMenuButton<String>(
                                    elevation: 4,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                    icon: Icon(
                                      size: 24,
                                      color: Color(0XFF666667),
                                      CupertinoIcons.ellipsis_vertical,
                                    ),
                                    onSelected: (value) {
                                      // if (value == 'edit') {
                                      //   _startEditing('post');
                                      // } else if (value == 'delete') {
                                      //   _showDeleteDialog(context);
                                      // } else if (value == 'report') {
                                      //   _showReportDialog(context);
                                      // }
                                      if (value == 'delete') {
                                        customDeleteDialog();
                                      } else if (value == 'report') {
                                        customReportDialog();
                                      }
                                    },
                                    position: PopupMenuPosition.under,
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                      
                                      // if (currentUserId == postAuthorId)
                                      //   PopupMenuItem<String>(
                                      //     value: 'edit',
                                      //     child: Container(
                                      //       width: 200,
                                      //       height: 20,
                                      //       child: Row(
                                      //         children: [
                                      //           Icon(Icons.edit),
                                      //           SizedBox(width: 8),
                                      //           Text('수정하기'),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      if (currentUserId == postAuthorId)
                                        PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Container(
                                            width: 200,
                                            height: 20,
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete),
                                                SizedBox(width: 8),
                                                Text('삭제하기'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (currentUserId != postAuthorId)
                                        PopupMenuItem<String>(
                                          value: 'report',
                                          child: Container(
                                            width: 200,
                                            height: 20,
                                            child: Row(
                                              children: [
                                                Icon(Icons.flag),
                                                SizedBox(width: 8),
                                                Text('신고하기'),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              if (widget.type != '자랑로그') 
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        StreamBuilder<String>(
                                          stream: getUserIcon(userId),
                                          builder: (context, snapshot) {
                                            final userIcon = snapshot.data ?? '';
                                            return Container(
                                              width: 24,
                                              height: 24,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFFFBA69),
                                                shape: const OvalBorder(),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  _getIconAsset(userIcon),
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(width: 5),
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
                                      ],
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
                            ],
                          ),
                        ),
                        if (widget.type != '자랑로그') ...[
                          Divider(thickness: 2, color: Color(0XFFF2F3F5)),
                          Container(
                            constraints: BoxConstraints(minHeight: 200),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
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
                                      LikeButton(postId: widget.postId, log4: false),
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
                                                  icon: Icon(CupertinoIcons.chat_bubble_2, color: Color(0XFF666667)),
                                                  onPressed: () {},
                                                ),
                                                Text(
                                                  '0',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Pretendard Variable",
                                                    color: Color(0XFF666667),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          final commentCount = snapshot.data!.docs.length;
                                          return Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(CupertinoIcons.chat_bubble_2, color: Color(0XFF666667)),
                                                onPressed: () {},
                                              ),
                                              Text(
                                                '$commentCount',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Pretendard Variable",
                                                  color: Color(0XFF666667),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: widget.onToggleBookmark,
                                                icon: Icon(
                                                  widget.isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                                                  size: 18,
                                                  color: Color(0XFF666667),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (widget.type == '자랑로그') ...[
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection('posts').doc(widget.postId).get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  height: 430,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              } else if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
                                return Container(
                                  height: 430,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: Center(child: Text("이미지를 불러오는데 실패했습니다.")),
                                );
                              } else {
                                final postData = snapshot.data!;
                                final imageUrl = postData['imageUrl'];

                                if (imageUrl != null && imageUrl.isNotEmpty) {
                                  return Container(
                                    height: 430,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    height: 430,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                    child: Center(child: Text("저장된 사진이 없습니다.")),
                                  );
                                }
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Row(
                              children: [
                                LikeButton(postId: widget.postId, log4: true),
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
                                            icon: Icon(CupertinoIcons.chat_bubble_2, color: Colors.black),
                                            onPressed: () {},
                                          ),
                                          Text(
                                            '0',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Pretendard Variable",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    final commentCount = snapshot.data!.docs.length;
                                    return Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(CupertinoIcons.chat_bubble_2, color: Color(0XFF666667),),
                                          onPressed: () {},
                                        ),
                                        Text(
                                          '$commentCount',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Pretendard Variable",
                                            color: Color(0XFF666667),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        IconButton(
                                          onPressed: widget.onToggleBookmark,
                                          icon: Icon(
                                            widget.isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                                            size: 18,
                                            color: Color(0XFF666667),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Pretendard Variable",
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            content,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Pretendard Variable",
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontFamily: "Pretendard Variable",
                            ),
                          ),
                        ],
                        Divider(thickness: 2, color: Color(0XFFF2F3F5)),
                        // Comments Section
                        CommentsSection(
                          postId: widget.postId,
                          currentUserId: FirebaseAuth.instance.currentUser?.uid ?? '',
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
    );
  }

  void customDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/deteledialog.png'),
              Positioned(
                bottom: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          '예',
                          style: TextStyle(
                            color: Color(0XFF2D2D2D),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _deletePost();
                        },
                      ),
                      SizedBox(width: 80),
                      TextButton(
                        child: Text(
                          '아니오',
                          style: TextStyle(
                            color: Color(0XFF2D2D2D),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void customReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/reportdialog.png'),
              Positioned(
                bottom: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          '예',
                          style: TextStyle(
                            color: Color(0XFF2D2D2D),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 80),
                      TextButton(
                        child: Text(
                          '아니오',
                          style: TextStyle(
                            color: Color(0XFF2D2D2D),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCustomSnackbar(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final snackbar = SnackBar(
      content: Container(
        width: double.infinity,
        color: Color(0XFFFFDCB2),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            message,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0XFFFFDCB2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      duration: Duration(seconds: 1),
    );
    scaffoldMessenger.showSnackBar(snackbar);
  }

  Future<void> _deletePost() async {
    try {
      await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .delete();
      Navigator.of(context).pop(); // Close the current screen and return to the previous screen.
      _showCustomSnackbar('게시물이 삭제되었습니다.');
    } catch (e) {
      print('게시물 삭제에 실패했습니다: $e');
      _showCustomSnackbar('게시물 삭제에 실패했습니다.');
    }
  }
}