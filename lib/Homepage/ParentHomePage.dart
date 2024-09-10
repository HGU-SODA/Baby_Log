import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Experts.dart';
import '../Homepage/Parent/info1.dart';
import '../Homepage/Parent/info2.dart';
import '../Homepage/Parent/info3.dart';

class ParentHomePage extends StatefulWidget {
  const ParentHomePage({super.key});

  @override
  _ParentHomePageState createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _nickname = "Loading..."; // 아이의 태명을 저장하는 변수
  int _textIndex = 0;
  final List<String> _texts = ['늘 감사해요!', '사랑해요~', '우헤헤~!', '엄마! 스마일~', '미~소~'];

  @override
  void initState() {
    super.initState();
    _fetchNickname(); // 태명 가져오는 함수 호출
  }

  // Firestore에서 아이의 태명을 불러오는 함수
  Future<void> _fetchNickname() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        setState(() {
          _nickname = userDoc.data()!['nickname'] ?? '태명 없음'; // 태명 설정
        });
      }
    }
  }

  void _changeText() {
    setState(() {
      _textIndex = (_textIndex + 1) % _texts.length;
    });
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
                      'assets/ParentHomePage.png',
                      width: 430,
                      height: 679,
                    ),
                  ),
                  Positioned(
                    top: 110,
                    //left: 120,

                    child: Container(
                      width: 200,
                      height: 50,
                      child: const Text(
                        '5살',
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
                    left: 170,
                    child: Container(
                      width: 200,
                      height: 50,
                      child: Text(
                        _nickname, // 업데이트된 태명 사용
                        style: const TextStyle(
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
                        textAlign: TextAlign.center,
                        '만난지',
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
                      child: const Text(
                        textAlign: TextAlign.center,
                        'D+1595',
                        style: TextStyle(
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

class ScrollCards extends StatelessWidget {
  const ScrollCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          '출산 후 안내사항',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Color(0XFFFFAB47),
          ),
        ),
        const Text(
          '<출산 후 건강한 회복을 위해서>',
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
                          text: '👶 ',
                          style: TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 17,
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '더 나은 산후조리를 위한 Tip',
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
                    '출산 후의 기간은 \'산후 조리\'라고도 불리며, 산모가\n출산 후 회복과 함께 신생아를 돌보는 중요한 시기...',
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
                          text: '🤰 모유 수유 및 아기 돌봄',
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
                    '모유는 아기에게 매우 중요한 영양소와 항체를 제공해요.\n출산 후 첫 3일 동안 나오는 초유는 아기의 면역 체계를...',
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
                          text: '❗ 출산 후 체크리스트',
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
                    '출산 후 약 6주가 지나면 의사와 함께 건강 검진을\n 받아야 해요. 또한 아기의 성장과 발달을 체크하기 위해...',
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
