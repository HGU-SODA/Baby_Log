import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// EditCommentForm에서 TextEditingController를 확인
class EditCommentForm extends StatefulWidget {
  final TextEditingController commentController;
  final String commentId;
  final String postId;
  final String formType;
  final Future<void> Function() onSave;

  const EditCommentForm({
    Key? key,
    required this.commentController,
    required this.commentId,
    required this.postId,
    required this.formType,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditCommentFormState createState() => _EditCommentFormState();
}

class _EditCommentFormState extends State<EditCommentForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

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
            final updatedContent = (context.findAncestorWidgetOfExactType<EditCommentForm>()?.commentController.text ?? '').trim();

            if (updatedContent.isNotEmpty) {
              try {
                await FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .doc(commentId)
                  .update({
                    'content': updatedContent,
                    'updatedAt': FieldValue.serverTimestamp(), // Optional: Track the update timestamp
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
                Navigator.of(context).pop(); // Close the form
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


  @override
  void dispose() {
    widget.commentController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onSave();
      Navigator.of(context).pop(); // Close the form on success
    } catch (e) {
      print('Failed to update: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formType == 'comment' ? 'Edit Comment' : 'Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isLoading) Center(child: CircularProgressIndicator()),
              TextFormField(
                controller: widget.commentController,
                decoration: InputDecoration(
                  labelText: widget.formType == 'comment' ? 'Edit Comment' : 'Edit Post',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Comment cannot be empty.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveChanges,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}