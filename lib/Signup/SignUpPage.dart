import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SignUpPage2.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _sendVerificationEmail() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('인증 이메일이 발송되었습니다. 이메일을 확인하세요.'),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      print("이메일 인증 실패: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이메일 인증 실패: ${e.toString()}'),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  Future<void> _verifyEmail() async {
    try {
      User? user = _auth.currentUser;
      await user?.reload();
      if (user != null && user.emailVerified) {
        // ID 중복 확인
        bool isDuplicate = await _checkDuplicateID(_idController.text.trim());
        if (isDuplicate) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('중복된 아이디입니다. 다른 아이디를 사용하세요.'),
              duration: Duration(milliseconds: 500),
            ),
          );
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이메일 인증 완료!'),
            duration: Duration(milliseconds: 500),
          ),
        );
        await _firestore.collection('users').doc(user.uid).set({
          'ID': _idController.text.trim(),
          'birthdate': _birthdateController.text.trim(),
          'email': _emailController.text.trim(),
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage2()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이메일 인증을 완료해주세요.'),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      print("이메일 확인 실패: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이메일 확인 실패: ${e.toString()}'),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  Future<bool> _checkDuplicateID(String id) async {
    final QuerySnapshot result =
        await _firestore.collection('users').where('ID', isEqualTo: id).get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.orange[50]!],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90.0),
                Image.asset('assets/logo_word.png', width: 183, height: 75),
                const SizedBox(height: 49),
                _buildTextField('아이디', _idController, false, hintText: '아이디'),
                const SizedBox(height: 16.0),
                _buildTextField('비밀번호', _passwordController, true,
                    hintText: '영문, 숫자, 특수문자 포함 8자리 이상'),
                const SizedBox(height: 16.0),
                _buildTextField('생년월일', _birthdateController, false,
                    hintText: 'YYYY/MM/DD',
                    keyboardType: TextInputType.datetime),
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(43.0, 0, 43, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '이메일 인증',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Pretendard Variable',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: 350,
                              height: 31,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: 350,
                                  child: TextField(
                                    controller: _emailController,
                                    cursorColor: const Color(0XFFFFDCB2),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: '~@gmail.com',
                                      hintStyle: const TextStyle(
                                        color: Color(0xFFA7A7A7),
                                        fontSize: 13,
                                        fontFamily: 'Pretendard Variable',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFA8A8A8)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFA7A7A7)),
                                      ),
                                      isCollapsed: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 43.0),
                      child: Container(
                        width: 69,
                        height: 27,
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: _sendVerificationEmail,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.5),
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFFF9C27)),
                            ),
                          ),
                          child: const Text(
                            '인증받기',
                            style: TextStyle(
                              color: Color(0xFFFF9C27),
                              fontSize: 13,
                              fontFamily: 'Pretendard Variable',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 240.0),
                SizedBox(
                  width: double.infinity,
                  height: 64.0,
                  child: ElevatedButton(
                    onPressed: _verifyEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9C27),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const Text(
                      '다음으로',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Pretendard Variable',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '뒤로가기',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D2D2D),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      padding: const EdgeInsets.fromLTRB(43.0, 0, 43, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: 350,
            height: 31,
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: TextField(
                controller: controller,
                cursorColor: const Color(0XFFFFDCB2),
                obscureText: isPassword,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFFA7A7A7),
                    fontSize: 13,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFA8A8A8)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFA7A7A7)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
