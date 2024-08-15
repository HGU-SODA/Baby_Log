import 'package:flutter/material.dart';

class Experts1_2 extends StatelessWidget {
  const Experts1_2({super.key});

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
                '7개월 ~ 8개월',
                style: TextStyle(
                  color: Color(0xFFFF9C27),
                  fontSize: 20,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 383,
                height: 219,
                child: const Text(
                  '-방아자세    \n오른발은 접어서 몸의 중심에, 왼발은 접어서 뒤로 보내고 손은 깍지 껴서 머리 뒤로 향하게 한 후 호흡을 내쉬면서 뒤로 보낸 발쪽으로 팔꿈치를 내려 보내고 시선은 위로 향합니다. (반복4회, 반대쪽도 동일)    \n    \n-합장합족자세    \n손발은 각각 마주 대고 손은 가슴 앞에 발은 당긴 후 내쉬면서 손은 위로, 발은 아래로 쭉 폅니다.    \n들이쉬면서 돌아와 반복합니다. (횟수는 개월 수에 따라 조절합니다.)',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 47),
              const Text(
                '9개월 ~ 10개월',
                style: TextStyle(
                  color: Color(0xFFFF9C27),
                  fontSize: 20,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 7),
              Image.asset(
                'assets/expert1Page3.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 383,
                height: 257,
                child: const Text(
                  '-분만호흡법\n진통의 진행 속도에 따라서 4단계로 나뉘며, 가장 기본이 되는 호흡은 복식 호흡법입니다.\n그러므로 임신 초기부터 꾸준히 복식호흡을 연습하는 것이 좋습니다.\n\n-허리틀기자세\n손은 바닥을 짚고 발을 쭉 편 상태에서 오른발을 들어 왼쪽 무릎 위에 세운 후, 호흡을 내쉬면서 왼쪽으로 무릎을 넘기고 시선은 오른쪽으로 돌립니다. (반복 4회, 반대쪽 동일)\n\n-기지개펴기\n허리와 팔, 발을 쭉 뻗어서 기지개 펴 줍니다.',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 42),
              Container(
                width: 375,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
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
                        '홈 화면으로',
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
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
