import 'package:baaby_log/Homepage/Pregnant/info2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'Experts.dart';
import '../Homepage/Pregnant/info1.dart';
import '../Homepage/Pregnant/info2.dart';
import '../Homepage/Pregnant/info3.dart';

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
    _fetchDueDate();
  }

  Future<void> _fetchDueDate() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        DateTime dueDate = DateTime.parse(userDoc.data()!['dueDate']);
        setState(() {
          _dueDate = DateFormat('yyyy.MM.dd').format(dueDate);
          _dDay = 'D-${_calculateDday(dueDate)}';
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
                      child: const Text(
                        '몽글이',
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

// 임신 전, 주차별, 출산 후 안내사항 카드
class ScrollCards extends StatelessWidget {
  const ScrollCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          '주차별 안내사항',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Color(0XFFFFAB47),
          ),
        ),
        const Text(
          '<임신 12주차>',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0XFF2D2D2D),
          ),
        ),
        const SizedBox(height: 33),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Info1()),
            );
          },
          child: Container(
            width: 370,
            height: 97,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: ShapeDecoration(
              color: const Color(0xFFFCFCFC),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1.50, color: Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '👶 태아의 심박동 소리',
                          style: TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 17,
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '임신 12주가 되면 태아의 심박동 소리를 들을 수 있습니다.\n다음 생리할 때가 돌아왔는데도 월경이 없다면',
                    style: TextStyle(
                      color: Color(0xFFA7A7A7),
                      fontSize: 15,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Info2()),
            );
          },
          child: Container(
            width: 370,
            height: 97,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: ShapeDecoration(
              color: const Color(0xFFFCFCFC),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1.50, color: Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '🤰 임신부의 피부에 나타나는 변화',
                          style: TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 17,
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '사람에 따라선 복부 중앙의 피부가 눈에 띄게 거무스름해지\n면서 흑선이라고 하는 수직선이 생기기도 하고 얼굴이나...',
                    style: TextStyle(
                      color: Color(0xFFA7A7A7),
                      fontSize: 15,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Info3()),
            );
          },
          child: Container(
            width: 370,
            height: 97,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: ShapeDecoration(
              color: const Color(0xFFFCFCFC),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1.50, color: Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '❗ 임신부의 신체에 나타나는 변화',
                          style: TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 17,
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '몸의 컨디션이 좋아지는 것을 느끼기 시작할 것이다.\n입덧이 서서히 사라지고, 아직은 배가 그리 크지 않아서...',
                    style: TextStyle(
                      color: Color(0xFFA7A7A7),
                      fontSize: 15,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
