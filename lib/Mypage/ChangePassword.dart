import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _showCustomSnackbar(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final snackbar = SnackBar(
      content: Container(
        height: 25,
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

  Future<void> _changePassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPasswordController.text,
        );
        await user.reauthenticateWithCredential(cred);

        await user.updatePassword(_newPasswordController.text);
        _showCustomSnackbar('비밀번호가 성공적으로 변경되었습니다.');
        Navigator.pop(context);
      }
    } catch (e) {
      print("비밀번호 변경 실패: $e");
      _showCustomSnackbar('비밀번호 변경 실패: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
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
            onPressed: _changePassword,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(23.0, 26, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '비밀번호 변경',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 18,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildPasswordField('현재 비밀번호', _currentPasswordController),
          const SizedBox(height: 16),
          _buildPasswordField('새 비밀번호', _newPasswordController),
          const SizedBox(height: 16),
          _buildPasswordField('비밀번호 확인', _confirmPasswordController),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: TextField(
        controller: controller,
        obscureText: true,
        cursorColor: Color(0XFFFF9C27),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          hintText: label,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0XFFA8A8A8), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0XFFA8A8A8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0XFFA8A8A8)),
          ),
        ),
      ),
    );
  }
}
