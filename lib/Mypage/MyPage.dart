import 'package:baaby_log/Mypage/ChangeNicknamePage.dart';
import 'package:baaby_log/Mypage/ChangePassword.dart';
import 'package:baaby_log/Mypage/ChangeIcon.dart';
import 'package:baaby_log/Mypage/MyPageAlarm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baaby_log/Signup/LogInPage.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _status = '';
  String _nickname = '';
  String _dueDate = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _status = userData['status'] ?? '';
        _nickname = userData['nickName'] ?? '';
        _dueDate = userData['dueDate'] ?? '';
      });
    }
  }

  String _getProfileImage() {
    switch (_status) {
      case '아기를 키우고 있어요':
        return 'assets/raise_mypage.png';
      case '임신 중이에요':
        return 'assets/pregnant_mypage.png';
      case '둘러볼게요':
        return 'assets/look_mypage.png';
      default:
        return 'assets/look_mypage.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Container(
              height: 370,
              child: Stack(
                children: [
                  Positioned(
                    top: 99.24,
                    left: 126,
                    child: Image.asset(
                      _getProfileImage(),
                      width: 180,
                      height: 204.76,
                    ),
                  ),
                  Positioned(
                    top: 320,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: Text(
                                _nickname,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Pretendard Variable",
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangeNicknamePage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 10, height: 67, color: const Color(0XFFF5F3EF)),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 32, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "내 계정 🔑",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Pretendard Variable",
                      color: Color(0XFF2D2D2D),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangeNicknamePage(),
                            ),
                          );
                        },
                        child: Text(
                          "닉네임 변경 ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangePasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          "비밀번호 변경 ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangeIconPage(),
                            ),
                          );
                        },
                        child: Text(
                          "아이콘 변경 ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                    ],
                  ),
                  const Divider(thickness: 3, color: Color(0XFFF5F3EF)),
                  const SizedBox(height: 37),
                  const Text(
                    "내 보관함 📌 ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Pretendard Variable",
                      color: Color(0XFF2D2D2D),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "주차별 안내사항",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "전문가 칼럼",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "커뮤니티",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      const SizedBox(height: 37),
                    ],
                  ),
                  const Divider(thickness: 3, color: Color(0XFFF5F3EF)),
                  const SizedBox(height: 37),
                  const Text(
                    "설정 ⚙️",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Pretendard Variable",
                      color: Color(0XFF2D2D2D),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyPageAlarm(),
                            ),
                          );
                        },
                        child: Text(
                          "알림",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      GestureDetector(
                        onTap: () async {
                          try {
                            // 현재 사용자 가져오기
                            User? user = FirebaseAuth.instance.currentUser;

                            if (user != null) {
                              // 계정 삭제
                              await user.delete();

                              // 계정 삭제 후 로그인 페이지로 이동
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (Route<dynamic> route) => false,
                              );
                            }
                          } catch (e) {
                            print("계정 삭제 중 오류 발생: $e");
                            if (e is FirebaseAuthException &&
                                e.code == 'requires-recent-login') {}
                          }
                        },
                        child: Text(
                          "로그아웃",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "계정 탈퇴",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard Variable",
                            color: Color(0XFF828282),
                          ),
                        ),
                      ),
                      const SizedBox(height: 66),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
