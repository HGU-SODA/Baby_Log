import 'package:flutter/material.dart';
import 'package:baaby_log/Homepage/Experts1_2.dart';

class Experts1 extends StatelessWidget {
  const Experts1({super.key});

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
                '임신 중 운동해도 될까요?',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 25,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 1.2, // Adjusted line height
                ),
              ),
              const SizedBox(height: 9),
              const Text(
                '필라테스 트레이너 / 심으뜸 대표',
                style: TextStyle(
                  color: Color(0xFFFF9C27),
                  fontSize: 15,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w600,
                  height: 1.2, // Adjusted line height
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                'assets/expert1Page.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: 383,
                height: 195,
                child: Text(
                  '순조로운 자연 분만을 위한 산모체조는 일반인과는 다른 몸의 상태를 가진 산모들의 상태에 맞도록 구성되어 있으며 대부분의 동작이 신체의 각 부분에 영향을 주는 동작으로 이루어집니다.\n\n또한 지나치게 체력이 떨어지는 것을 예방하는 체조 동작 이외에도 출산의 긴 시간을 잘 견딜 수 있는 호흡법, 태교를 겸한 명상 시간, 임신 중 발생하는 신체 각 부분의 통증을 완화시키는 경락법등의 다양한 프로그램으로 이루어져 있는 것이 특징입니다.',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w400,
                    height: 0,
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
                '16주 ~ 6개월',
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
                'assets/expert1Page2.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 350,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '-복식호흡',
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
                            '\n복식호흡은 배로 숨을 쉰다는 의미로 수면을 취할 때 하는 호흡이 바로 복식호흡입니다. \n \n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '-고양이 자세          \n',
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
                            '손바닥과 무릎을 대고 엎드려 호흡을 들이쉬며 시선은 위로 다시 내쉬면서 고개를 최대한 안으로 말아 넣고 등도 둥글게 올립니다.          \n          \n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '-나비자세        \n',
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
                            '양 발바닥을 마주 대고 손으로 발을 모아 잡은 후 허리를 바르게 펴고 양 무릎을 위아래로 20회이상 흔들어 줍니다.        \n        \n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '-스트레칭          \n',
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
                            '바닥에 다리를 펴고 앉아서 몸을 스트레칭 시킵니다.          \n다리를 폈다가 양옆으로 벌리고 내쉬면서 가슴을 바닥에 닿을 정도로 내려줍니다.',
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
              SizedBox(height: 42),
              Container(
                width: 375,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Experts1_2()),
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
