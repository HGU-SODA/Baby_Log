import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'CommentLikeButton.dart';
import 'CommentPopupMenu.dart';
import 'EditCommentForm.dart';

class CommentsSection extends StatefulWidget {
  final String postId;
  final String currentUserId;

  CommentsSection({required this.postId, required this.currentUserId});

  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  void _editComment(String commentId, String initialContent) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCommentForm(
          commentController: TextEditingController(text: initialContent),
          commentId: commentId,
          postId: widget.postId,
          formType: 'comment',
          onSave: () async {
            final updatedContent = (context
                        .findAncestorWidgetOfExactType<EditCommentForm>()
                        ?.commentController
                        .text ??
                    '')
                .trim();

            if (updatedContent.isNotEmpty) {
              try {
                await FirebaseFirestore.instance
                    .collection('posts')
                    .doc(widget.postId)
                    .collection('comments')
                    .doc(commentId)
                    .update({
                  'content': updatedContent,
                  'updatedAt': FieldValue.serverTimestamp(),
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Comment updated successfully!')),
                );
              } catch (e) {
                print('Failed to update comment: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update comment: $e')),
                );
              } finally {
                Navigator.of(context).pop();
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Comment cannot be empty.')),
              );
            }
          },
        ),
      ),
    );
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final comments = snapshot.data!.docs;

        return Column(
          children: comments.map((comment) {
            final commentData = comment.data() as Map<String, dynamic>;
            final commentId = comment.id;
            final commentAuthorId = commentData['authorId'];
            final content = commentData['content'];
            final createdAt = commentData['createdAt']?.toDate();
            final DateFormat dateFormat = DateFormat('MM.dd. HH:mm');
            final formattedDate =
                dateFormat.format(createdAt ?? DateTime.now());

            return Container(
              margin: EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StreamBuilder<String>(
                        stream: getUserIcon(commentAuthorId),
                        builder: (context, snapshot) {
                          final userIcon = snapshot.data ?? '';
                          return Container(
                            width: 23,
                            height: 23,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFBA69),
                              shape: const OvalBorder(),
                            ),
                            child: Center(
                              child: Image.asset(
                                _getIconAsset(userIcon),
                                width: 13,
                                height: 13,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 6),
                      Column(
                        children: [
                          SizedBox(height: 12),
                          Text(
                            commentData['authorNickname'],
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0XFF2D2D2D),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Inter",
                            ),
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
                        ],
                      ),
                      Spacer(),
                      CommentLikeButton(
                          postId: widget.postId, commentId: commentId),
                      CommentPopupMenu(
                        currentUserId: widget.currentUserId,
                        commentAuthorId: commentAuthorId,
                        commentId: commentId,
                        postId: widget.postId,
                        onEdit: () {
                          _editComment(commentId, content);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 28),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Pretendard Variable",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
