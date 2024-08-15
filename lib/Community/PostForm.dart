// FAB 버튼 -> 글 생성하는 화면
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:baaby_log/Diary/UploadImage.dart';

class PostForm extends StatefulWidget {
  final String initialType;
  final String currentUserId;

  PostForm({required this.initialType, required this.currentUserId});

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  late String _postType;
  final List<String> _categories = ['자유로그', '질문로그', '꿀팁로그', '자랑로그'];
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _postType = widget.initialType;
  }

  Future<String?> _uploadImage(Uint8List imageBytes) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('post_images')
          .child(DateTime.now().toIso8601String() + '.jpg');
      await ref.putData(imageBytes);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Image upload failed: $e');
      return null;
    }
  }

  Future<void> _submitForm() async {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty && _postType.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final nickname = userDoc.data()?['nickName'] ?? '닉네임 없음';

        String? imageUrl;
        if (_postType == '자랑로그' && _imageBytes != null) {
          imageUrl = await _uploadImage(_imageBytes!);
        }

        await FirebaseFirestore.instance.collection('posts').add({
          'title': title,
          'content': content,
          'type': _postType,
          'createdAt': Timestamp.now(),
          'likesCount': 0,
          'authorId': user.uid, // authorId
          'authorNickname': nickname, // 닉네임
          'imageUrl': imageUrl, // 이미지 URL
        });

        _showCustomSnackbar();
        Navigator.pop(context, 'fromPostForm');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('사용자 정보 가져오기 실패')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 필드를 채워주세요')),
      );
    }
  }

  void _showCustomSnackbar() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final snackbar = SnackBar(
      content: Container(
        height: 25,
        width: double.infinity,
        color: Color(0XFFFFDCB2),
        child: Center(
          child: Text(
            '업로드되었습니다!',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, 'fromPostForm');
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0XFF1C1B1F)),
        ),
        title: Center(
          child: Text(
            '글 쓰기',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0XFFFF9C27),
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            child: Text(
              '완료',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0XFFFF9C27),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            onPressed: _submitForm,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12,
                children: _categories.map((category) {
                  return ChoiceChip(
                    showCheckmark: false,
                    label: Text(
                      category,
                      style: TextStyle(
                        color: _postType == category
                            ? Colors.white
                            : Color(0XFFFF9C27),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: Color(0XFFFF9C27),
                    side: BorderSide(color: Color(0XFFFF9C27)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    selected: _postType == category,
                    onSelected: (selected) {
                      setState(() {
                        // 이미 선택된 로그가 아닌 경우에만 상태 변경
                        if (_postType != category) {
                          _postType = category;
                          _imageBytes = null; // 선택 로그가 변경될 때 이미지 초기화
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              if (_postType == '자랑로그') ...[
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.white,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (_imageBytes != null)
                        Image.memory(
                          _imageBytes!,
                          fit: BoxFit.cover,
                        ),
                      // else if (_imageUrl != null)
                      //   Image.network(
                      //     _imageUrl!,
                      //     fit: BoxFit.cover,
                      //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      //       if (loadingProgress == null) return child;
                      //       return Center(
                      //         child: CircularProgressIndicator(
                      //           value: loadingProgress.expectedTotalBytes != null
                      //               ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes!)
                      //               : null,
                      //         ),
                      //       );
                      //     },
                      //     errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      //       return Center(child: Text('이미지를 불러오는 중 문제가 발생했습니다.'));
                      //     },
                      //   ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: UploadImage(
                          onPickImage: (bytes) {
                            setState(() {
                              _imageBytes = bytes;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // if (_imageBytes != null)
                //   Image.memory(
                //     _imageBytes!,
                //     height: 300,
                //     width: double.infinity,
                //     fit: BoxFit.cover,
                //   ),
                // SizedBox(height: 10),
                // UploadImage(
                //   onPickImage: (bytes) {
                //     setState(() {
                //       _imageBytes = bytes;
                //     });
                //   },
                // ),
                SizedBox(height: 20),
                Divider(thickness: 2, color: Color(0XFFF2F3F5)),
                TextField(
                  controller: _titleController,
                  cursorColor: Color(0XFFFFDCB2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '제목',
                    hintStyle: TextStyle(
                      color: Color(0XFFA8A8A8),
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  maxLines: 1,
                ),
                TextField(
                  controller: _contentController,
                  cursorColor: Color(0XFFFFDCB2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '내용을 입력하세요.',
                    hintStyle: TextStyle(
                      color: Color(0XFFA8A8A8),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxLines: null,
                ),
              ] else ...[
                TextField(
                  controller: _titleController,
                  cursorColor: Color(0XFFFFDCB2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '제목',
                    hintStyle: TextStyle(
                      color: Color(0XFFA8A8A8),
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  maxLines: 1,
                ),
                Divider(thickness: 2, color: Color(0XFFF2F3F5)),
                TextField(
                  controller: _contentController,
                  cursorColor: Color(0XFFFFDCB2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '내용을 입력하세요.',
                    hintStyle: TextStyle(
                      color: Color(0XFFA8A8A8),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxLines: null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
