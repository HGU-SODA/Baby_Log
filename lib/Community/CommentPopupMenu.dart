import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentPopupMenu extends StatefulWidget {
  final String currentUserId;
  final String commentAuthorId;
  final String commentId;
  final String postId;
  final VoidCallback onEdit;

  CommentPopupMenu({
    required this.currentUserId,
    required this.commentAuthorId,
    required this.commentId,
    required this.postId,
    required this.onEdit,
  });

  @override
  State<CommentPopupMenu> createState() => _CommentPopupMenuState();
}

class _CommentPopupMenuState extends State<CommentPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19),
      ),
      icon: Icon(
        size: 19,
        color: Color(0XFF666667),
        Icons.more_vert,
      ),
      onSelected: (value) {
        // if (value == 'edit') {
        //   widget.onEdit();
        // } else if (value == 'delete') {
        //   _showDeleteCommentDialog(context);
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
        // if (widget.currentUserId == widget.commentAuthorId)
        //   PopupMenuItem<String>(
        //     value: 'edit',
        //     child: Row(
        //       children: [
        //         Icon(Icons.edit),
        //         SizedBox(width: 8),
        //         Text('수정하기'),
        //       ],
        //     ),
        //   ),
        if (widget.currentUserId == widget.commentAuthorId)
          PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 8),
                Text('삭제하기'),
              ],
            ),
          ),
        if (widget.currentUserId != widget.commentAuthorId)
          PopupMenuItem<String>(
            value: 'report',
            child: Row(
              children: [
                Icon(Icons.flag),
                SizedBox(width: 8),
                Text('신고하기'),
              ],
            ),
          ),
      ],
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
                          _deleteComment(widget.commentId);
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

  // 댓글 삭제
  Future<void> _deleteComment(String commentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .doc(commentId)
          .delete();
      _showCustomSnackbar('댓글이 삭제되었습니다.');
    } catch (e) {
      print('댓글 삭제에 실패했습니다: $e');
      _showCustomSnackbar('댓글 삭제에 실패했습니다.');
    }
  }
}