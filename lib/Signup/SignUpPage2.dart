import 'package:baaby_log/Homepage/LookHomePage.dart';
import 'package:baaby_log/Homepage/ParentHomePage.dart';
import 'package:baaby_log/Homepage/PregnantHomePage.dart';
import 'package:baaby_log/Signup/Pregnant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../navigationBar.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({Key? key}) : super(key: key);

  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedIcon = '';

  Future<void> _saveAdditionalInfo() async {
    if (_nickNameController.text.trim().isEmpty ||
        _genderController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('닉네임과 성별을 모두 입력해주세요.'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }

    bool isDuplicate =
        await _checkDuplicateNickname(_nickNameController.text.trim());
    if (isDuplicate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이미 사용 중인 닉네임입니다. 다른 닉네임을 사용하세요.'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String? nickname =
            (_selectedIcon == '둘러볼게요' || _selectedIcon == '아기를 키우고 있어요')
                ? '몽글이'
                : null;

        await _firestore.collection('users').doc(user.uid).update({
          'nickName': _nickNameController.text.trim(),
          'gender': _genderController.text.trim(),
          'status': _selectedIcon,
          'nickname': nickname,
          'dueDate': _selectedIcon == '임신 중이에요' ? null : 'default',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('추가 정보가 저장되었습니다.'),
            duration: Duration(milliseconds: 500),
          ),
        );

        if (_selectedIcon == '임신 중이에요') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PregnantPage()),
          );
        } else if (_selectedIcon == '둘러볼게요' || _selectedIcon == '아기를 키우고 있어요') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => navigationBar()),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('사용자 정보가 없습니다. 다시 시도해주세요.'),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      print("추가 정보 저장 실패: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('추가 정보 저장 실패: ${e.toString()}'),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  Future<bool> _checkDuplicateNickname(String nickname) async {
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('nickName', isEqualTo: nickname)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.isNotEmpty;
  }

  Widget _buildIcon(String label, String imageAsset) {
    return Padding(
      padding: const EdgeInsets.only(left: 43.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIcon = label;
          });
        },
        child: Row(
          children: [
            Container(
              width: 37,
              height: 37,
              decoration: ShapeDecoration(
                color: _selectedIcon == label
                    ? const Color(0xFFFF9C27)
                    : const Color(0xFFFFDFBB),
                shape: const OvalBorder(),
              ),
              child: Center(
                child: Image.asset(
                  imageAsset,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
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
                _buildTextField('닉네임', _nickNameController, false,
                    hintText: '닉네임'),
                const SizedBox(height: 16.0),
                _buildTextField('성별', _genderController, false, hintText: '성별'),
                const SizedBox(height: 66.5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(43.0, 0, 0, 10),
                    child: Text('아이콘 설정',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                _buildIcon('둘러볼게요', 'assets/sun.png'),
                const SizedBox(height: 16.0),
                _buildIcon('임신 중이에요', 'assets/leaf.png'),
                const SizedBox(height: 16.0),
                _buildIcon('아기를 키우고 있어요', 'assets/sprout.png'),
                const SizedBox(height: 150.0),
                SizedBox(
                  width: double.infinity,
                  height: 64.0,
                  child: ElevatedButton(
                    onPressed: _saveAdditionalInfo,
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
}
