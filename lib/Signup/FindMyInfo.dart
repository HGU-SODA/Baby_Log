import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FindMyInfoPage extends StatefulWidget {
  const FindMyInfoPage({Key? key}) : super(key: key);

  @override
  _FindMyInfoPageState createState() => _FindMyInfoPageState();
}

class _FindMyInfoPageState extends State<FindMyInfoPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isFindingId = true;

  Future<void> _findMyID() async {
    try {
      QuerySnapshot result = await _firestore
          .collection('users')
          .where('email', isEqualTo: _emailController.text.trim())
          .get();

      if (result.docs.isNotEmpty) {
        String userId = result.docs.first.get('ID');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('아이디는 $userId 입니다.'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('해당 이메일로 등록된 아이디가 없습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('아이디 찾기 실패: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _resetPassword() async {
    try {
      // 아이디 확인
      QuerySnapshot result = await _firestore
          .collection('users')
          .where('ID', isEqualTo: _idController.text.trim())
          .where('email', isEqualTo: _emailController.text.trim())
          .get();

      if (result.docs.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('비밀번호 재설정 이메일이 발송되었습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('입력한 아이디와 이메일이 일치하지 않습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('비밀번호 재설정 실패: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
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
            '아이디/비밀번호 찾기',
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 20,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(
              '이메일',
              _emailController,
              false,
              hintText: '이메일을 입력하세요',
            ),
            if (!_isFindingId) ...[
              const SizedBox(height: 20.0),
              _buildTextField(
                '아이디',
                _idController,
                false,
                hintText: '아이디를 입력하세요',
              ),
            ],
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isFindingId ? _findMyID : _resetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9C27),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
              ),
              child: Text(
                _isFindingId ? '아이디 찾기' : '비밀번호 재설정',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                setState(() {
                  _isFindingId = !_isFindingId;
                  _emailController.clear();
                  _idController.clear();
                });
              },
              child: Text(
                _isFindingId ? '비밀번호 찾기로 전환' : '아이디 찾기로 전환',
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D2D2D),
                  //decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isPassword, {
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller,
            cursorColor: const Color(0XFFFFDCB2),
            obscureText: isPassword,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFFA7A7A7),
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFA7A7A7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
