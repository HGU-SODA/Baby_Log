import 'package:flutter/material.dart';
import '../Homepage/Experts2_2.dart';

class Experts2 extends StatelessWidget {
  const Experts2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '조기 진통이 있다면?',
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
                '서울아산병원 / 김경미 교수',
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
                'assets/expert2Page.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: 383,
                height: 165,
                child: Text(
                  '조산아는 전 세계적으로 신생아 출생 전후에 발생되는 질환 및 사망의 주요 원인이 되며, 전체 분만의 5~9%를 차지하고, 만삭아에 비해 그 사망 위험이 180배 증가되는 것으로 알려져 있습니다.\n\n이러한 조기분만은 심각한 후유증으로 뇌성마비 망막질환 및 만성폐질환등의 장기적인 장애가    생길 수 있어 사회적으로 많은 관심을 불러일으키고 있습니다.',
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
                '조기진통 증상',
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
                'assets/expert2Page2.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 281,
                child: Text(
                  '조기진통은 임신 20주에서 만 37주 사이에 적어도 10분 간격으로 30초 이상 지속되는 규칙적인 자궁 수축이 있을 때이며 이때 산모는 진통을 느끼기도 하지만 별 진통 없이 배가 단단해지는 것만을 느끼기도 합니다.    \n    \n가진통이라 하여 주로 임신 중반기 이후에 자궁수축을 경험하게 되는데 대개 그 강도가 세지 않으며 규칙적이지 않고 결국 자궁수축이 없어지게 됩니다. 가진통의 경우 자궁경부가 열리지는 않습니다.    \n    \n그외 "이슬"이라 하는 질분비물 즉 피가 묻은 점액성 질분비물이 같이 나오기도 하며,양막 파수의 경우 맑은 물과 같은 질 분비물이 나오게 됩니다. 그러나 허리가 뻐근할 정도의 경미한 증상을 나타내는 경우도 있습니다.',
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
                      MaterialPageRoute(
                          builder: (context) => const Experts2_2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9C27),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    shadowColor: const Color(0x3FFFAB47),
                    elevation: 8,
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
