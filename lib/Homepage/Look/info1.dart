import 'package:baaby_log/Homepage/Look/info1_2.dart';
import 'package:flutter/material.dart';

class Info1 extends StatelessWidget {
  const Info1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Removes shadow under the AppBar
        iconTheme: const IconThemeData(
            color: Colors.black), // Changes the back icon color to black
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '👶 배란 주기 이해하기',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 25,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                'assets/info1_1.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 82,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '🧐 임신을 계획중이신가요? \n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text:
                            '임신을 계획 중이라면, 배란 주기를 정확히 이해하고, 임신 가능 시기를 파악하는 것이 아주 중요해요.\n먼저 생리 주기와 배란, 배란 징후에 대해서 설명드릴게요.',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 36, 0, 24),
                child: Container(
                  width: 380,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.50,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFF5F2EF),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                '1. 생리 주기란?',
                style: TextStyle(
                  color: Color(0xFFFF9C27),
                  fontSize: 20,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(height: 14),
              Image.asset(
                'assets/info1_2.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 124,
                child: Text(
                  '생리 주기는 월경 첫날부터 다음 월경이 시작되기 전날까지의 기간을 말해요. 보통 28일 정도의 주기가 일반적이지만, 21일에서 35일 사이의 주기도 정상 범위에 속한답니다.\n\n❗생리 주기는 개개인마다 다를 수 있으니, 자신의 주기를 잘 이해하는 것이 중요해요.\n',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height: 42),
              Container(
                width: 375,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Info1_2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9C27),
                    padding: EdgeInsets.zero, // Removes default padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    shadowColor: const Color(0x3FFFAB47),
                    elevation: 8, // Matches the blurRadius of the shadow
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '다음으로',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
