import 'dart:ffi';

import 'package:baaby_log/Homepage/Look/info3_2.dart';
import 'package:flutter/material.dart';

class Info3 extends StatelessWidget {
  const Info3({super.key});

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
                '🤰 체중 관리 및 영양 섭취',
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
                'assets/info3_1.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 105,
                child: Text(
                  '안녕하세요😊 건강한 임신을 준비하기 위해서는 체중 관리와 영양 섭취가 매우 중요해요. 이 두 가지는 엄마와 아기 모두의 건강에 큰 영향을 미치기 때문에 임신 전부터 잘 관리하는 것이 필요하답니다. 아래에서 체중 관리와 영양 섭취에 대해 자세히 설명드릴게요.',
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
                '1. 적정 체중 유지하기',
                style: TextStyle(
                  color: Color(0xFFFF9C27),
                  fontSize: 20,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(height: 14),
              SizedBox(
                width: 383,
                height: 210,
                child: Text(
                  '임신 전 체중이 너무 낮거나 높으면 임신 중 합병증 위험이 커질 수 있어요. 저체중일 경우, 태아 발육 부전이나 조산의 위험이 높아질 수 있고, 과체중 또는 비만일 경우에는 임신성 당뇨, 고혈압, 그리고 출산 시 합병증의 위험이 높아질 수 있답니다. 따라서 임신을 계획하고 있다면, 먼저 자신의 체질량지수(BMI)를 확인해 보세요.\n\n🎈 체질량지수(BMI): BMI는 체중(kg)을 키(m)의 제곱으로 나눈 값이에요. 일반적으로 18.5~24.9가 정상 범위로 간주되며, 이 범위 내에서 체중을 유지하는 것이 좋답니다.',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height: 21),
              Container(
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
              SizedBox(height: 30),
              Image.asset(
                'assets/info3_2.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                '2. 체중 조절하기 ',
                style: TextStyle(
                  color: Color(0xFFFF9C27),
                  fontSize: 20,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: 383,
                height: 257,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '임신 전에 적정 체중을 유지하기 위해 ',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '“균형 잡힌 식단',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '”과 ',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '“규칙적인 운동”',
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
                            '이 필요해요. 체중을 조절하기 위해 무리하게 다이어트를 하는 것은 좋지 않지만, 건강한 식습관과 운동을 통해 서서히 체중을 조절하는 것은 바람직해요.\n\n     체중 감량을 위해: 과체중이시라면, 하루 섭취 칼로리를 조금 줄이고, 신선한 채소와 과일, 고단백 식품을 섭취하는 것이 좋습니다. 또한 규칙적인 유산소 운동을 통해 체중을 서서히 감량해 보세요.\n\n⬆ 체중 증가를 위해: 저체중이시라면, 하루 섭취 칼로리를 조금씩 늘리고, 건강한 지방(견과류, 아보카도, 올리브유 등)과 단백질이 풍부한 음식을 추가하는 것이 좋아요.',
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
                      MaterialPageRoute(builder: (context) => const Info3_2()),
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
