import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Signup/LogInPage.dart';

class DeletePage extends StatefulWidget {
  final String nickname;

  const DeletePage({super.key, required this.nickname});

  @override
  _DeletePageState createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  final TextEditingController _nicknameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _showCustomSnackbar(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    scaffoldMessenger.showSnackBar(snackbar);
  }

  Future<void> _deleteAccount() async {
    String enteredNickname = _nicknameController.text.trim();

    if (enteredNickname == widget.nickname) {
      try {
        User? user = _auth.currentUser;
        if (user != null) {
          await user.delete();
          _showCustomSnackbar("계정이 삭제되었습니다!");

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        print("계정 삭제 중 오류 발생: $e");
        if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
          _showCustomSnackbar("최근에 로그인하지 않았습니다. 다시 로그인해주세요.");
        }
      }
    } else {
      _showCustomSnackbar("닉네임이 일치하지 않습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            '내 계정',
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 20,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _deleteAccount,
            child: const Text(
              '완료',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '계정 탈퇴',
              style: TextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 18,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              cursorColor: const Color(0XFFFFDCB2),
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: widget.nickname,
                hintText: '닉네임을 입력해주세요',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFFA7A7A7)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '*탈퇴를 위해 닉네임을 입력해주세요.',
              style: TextStyle(
                color: Color(0xFF818181),
                fontSize: 15,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
