// FAB 버튼 -> 글 생성하는 화면
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _postType = widget.initialType;
  }

  void _showCustomSnackbar() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final snackbar = SnackBar(
      content: Container(
        width: double.infinity,
        color: Color(0XFFFFDCB2),
        padding: EdgeInsets.symmetric(vertical: 10),
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

        await FirebaseFirestore.instance.collection('posts').add({
          'title': title,
          'content': content,
          'type': _postType,
          'createdAt': Timestamp.now(),
          'likesCount': 0,
          'authorId': user.uid, // authorId 저장
          'authorNickname': nickname, // 닉네임 저장
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
                spacing: 8.0,
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
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
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
          ),
        ),
      ),
    );
  }
}
