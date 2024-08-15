import 'package:baaby_log/Homepage/Look/info2.dart';
import 'package:flutter/material.dart';
import 'Experts.dart';
import '../Homepage/Look/info1.dart';
import '../Homepage/Look/info3.dart';

class LookHomePage extends StatelessWidget {
  const LookHomePage({super.key});

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
                  Image.asset(
                    'assets/LookHomePage.png',
                    width: 430,
                    height: 431,
                  ),
                  Positioned(
                    top: 124,
                    child: Container(
                      width: 200,
                      height: 50,
                      child: const Text(
                        '세상은 어떤 곳일까?',
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
                ],
              ),
              const SizedBox(height: 40),
              ScrollCards(),
              SizedBox(height: 84),
              Divider(thickness: 10, height: 67, color: Color(0XFFF5F3EF)),
              // 임신 전 안내사항 카드 부분 추가
              Experts(),
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
        Text(
          '임신 전 안내사항',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Color(0XFFFFAB47),
          ),
        ),
        Text(
          '<건강한 임신을 위한 준비>',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0XFF2D2D2D),
          ),
        ),
        SizedBox(height: 33),
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
              padding: const EdgeInsets.only(left: 14.0),
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
                          text: '배란 주기 이해하기',
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
                  const SizedBox(height: 8.0),
                  Text(
                    '배란 주기를 이해하며 임신 가능 시기를 파악해요.\n이는 임신을 계획하는데 있어서 중요한 부분이에요.',
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
        SizedBox(height: 10),
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
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '🤰 임신 가능 시기 파악하기',
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
                  const SizedBox(height: 8.0),
                  Text(
                    '임신을 계획 중이라면 임신 가능 시기를 계산하여 \n임신 확률을 높일 수 있어요. 임신 가능 시기 파악을...',
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
        SizedBox(height: 10),
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
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '🍅 체중 관리 및 영양 섭취',
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
                  const SizedBox(height: 8.0),
                  Text(
                    '건강한 체중을 유지하는 것은 임신에 매우 중요해요.\n체질량지수(BMI)가 19~24 사이인 경우 임신 확률이...',
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
