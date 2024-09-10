import 'package:baaby_log/Homepage/LookHomePage.dart';
import 'package:baaby_log/Homepage/Pregnant/info2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'Experts.dart';
import '../Homepage/Pregnant/info1.dart';
import '../Homepage/Pregnant/info2.dart';
import '../Homepage/Pregnant/info3.dart';
import '../Mypage/ChangeBabyInfo.dart';

class PregnantHomePage extends StatefulWidget {
  const PregnantHomePage({super.key});

  @override
  _PregnantHomePageState createState() => _PregnantHomePageState();
}

class _PregnantHomePageState extends State<PregnantHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _dueDate = "Loading...";
  String _dDay = "Calculating...";
  String _nickname = "Loading..."; // 아이의 태명을 저장하는 변수

  int _textIndex = 0;
  final List<String> _texts = [
    '얼른 보고 싶어요!',
    '히야아아!',
    '기다려주세요!',
    '엄마가 제일 좋아!',
    '우리 곧 만나요!'
  ];

  void _changeText() {
    setState(() {
      _textIndex = (_textIndex + 1) % _texts.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDueDateAndNickname(); // 태명도 함께 가져오도록 수정
  }

  Future<void> _fetchDueDateAndNickname() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        DateTime dueDate = DateTime.parse(userDoc.data()!['dueDate']);
        String nickname = userDoc.data()!['nickname'] ?? "태명 없음"; // 태명 가져오기
        setState(() {
          _dueDate = DateFormat('yyyy.MM.dd').format(dueDate);
          _dDay = 'D-${_calculateDday(dueDate)}';
          _nickname = nickname; // 태명 설정
        });
      }
    }
  }

  int _calculateDday(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: _changeText,
                    child: Image.asset(
                      'assets/PregnantHomePage.png',
                      width: 430,
                      height: 679,
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 110,
                    child: Container(
                      width: 200,
                      height: 50,
                      child: const Text(
                        '12주차',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 23,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 190,
                    child: Container(
                      width: 200,
                      height: 50,
                      child: Text(
                        _nickname, // 업데이트된 태명 사용
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    child: Container(
                      width: 200,
                      height: 50,
                      child: Text(
                        _dueDate + ' 예정',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFFF9C27),
                          fontSize: 18,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 247,
                    child: Container(
                      width: 200,
                      height: 50,
                      child: Text(
                        _texts[_textIndex],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 25,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 552,
                    child: Container(
                      width: 200,
                      height: 50,
                      child: const Text(
                        '만나기까지',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 20,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 582,
                    child: Container(
                      width: 200,
                      height: 50,
                      child: Text(
                        _dDay,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFFF9C27),
                          fontSize: 25,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const ScrollCards(),
              const SizedBox(height: 84),
              const Divider(
                thickness: 10,
                height: 67,
                color: Color(0XFFF5F3EF),
              ),
              const Experts(),
            ],
          ),
        ),
      ),
    );
  }
}
