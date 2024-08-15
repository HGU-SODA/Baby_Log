import 'package:baaby_log/Community/bookmark_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'CommentSection.dart';
import 'DefaultPostDetail.dart';
import 'EditCommentForm.dart';
import 'EditForm.dart';
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final BookmarkService _bookmarkService = BookmarkService();
  bool _isSaved = false;
  bool _isEditing = false; // 수정 모드
  String? _editType;
  String? _commentId;

  @override
  void initState() {
    super.initState();
    _loadBookmarkState();
    _getPost();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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

  // 댓글 추가
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

  void _showCustomSnackbar(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final snackbar = SnackBar(
      content: Container(
        height: 20,
        width: double.infinity,
        color: Color(0XFFFFDCB2),
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

  Future<DocumentSnapshot<Object?>> _getPost() async {
    //_loadPostData
    final post = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .get();
    return post;
  }

  Future<void> _loadCommentData(String commentId) async {
    final commentDoc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(commentId)
        .get();
    if (commentDoc.exists) {
      setState(() {
        _commentController.text = commentDoc['content'];
      });
    }
  }

  void _startEditing(String formType,
      {String? commentId, String? initialContent}) {
    setState(() {
      _isEditing = true;
      _editType = formType;
      _commentId = commentId;
      if (initialContent != null) {
        _commentController.text = initialContent;
      }
    });
  }

  Future<void> _savePost() async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .update({
        'title': _titleController.text,
        'content': _contentController.text,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      setState(() {
        _isEditing = false;
      });
      _showCustomSnackbar('게시물이 수정되었습니다.');
    } catch (e) {
      print('Failed to update post: $e');
      _showCustomSnackbar('게시물 수정에 실패했습니다.');
    }
  }

  Future<void> _saveComment() async {
    if (_commentId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .collection('comments')
            .doc(_commentId)
            .update({
          'content': _commentController.text,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        setState(() {
          _isEditing = false;
        });
        _showCustomSnackbar('댓글이 수정되었습니다.');
      } catch (e) {
        print('Failed to update comment: $e');
        _showCustomSnackbar('댓글 수정에 실패했습니다.');
      }
    }
  }

  void _loadBookmarkState() async {
    final userId = _bookmarkService.getCurrentUserId();
    if (userId != null) {
      bool isSaved =
          await _bookmarkService.getBookmarkStatus(userId, widget.postId);
      setState(() {
        _isSaved = isSaved;
      });
    }
  }

  void _toggleBookmark() async {
    final userId = _bookmarkService.getCurrentUserId();
    if (userId != null) {
      await _bookmarkService.toggleBookmark(userId, widget.postId);
      setState(() {
        _isSaved = !_isSaved;
      });
    }
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isEditing
            ? (_editType == 'post'
                ? EditForm(
                    titleController: _titleController,
                    contentController: _contentController,
                    onSave: () async {
                      await _savePost();
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    formType: 'post',
                  )
                : EditCommentForm(
                    commentController: _commentController,
                    commentId: _commentId ?? '',
                    postId: widget.postId,
                    formType: 'comment',
                    onSave: () async {
                      await _saveComment();
                      setState(() {
                        _isEditing = false;
                      });
                    },
                  ))
            : DefaultPostDetail(
                postId: widget.postId,
                type: widget.type,
                commentController: _commentController,
                scrollController: _scrollController,
                isSaved: _isSaved,
                onToggleBookmark: _toggleBookmark,
                getCurrentUserNickname: _getCurrentUserNickname,
                getPostAuthorNickname: _getPostAuthorNickname,
                getPostAuthorId: _getPostAuthorId,
                getPost: _getPost,
                onEdit: (formType,
                    {String? commentId, String? initialContent}) {
                  _startEditing(formType,
                      commentId: commentId, initialContent: initialContent);
                },
              ),
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
