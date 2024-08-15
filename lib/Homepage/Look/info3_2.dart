import 'package:flutter/material.dart';

class Info3_2 extends StatelessWidget {
  const Info3_2({super.key});

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
                '3. 균형 잡힌 영양 섭취',
                style: TextStyle(
                  color: Color(0xFFFF9C27),
                  fontSize: 20,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 12),
              Image.asset(
                'assets/info3_3.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 383,
                height: 344,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '🥦 엽산 섭취',
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
                            ': 엽산은 태아의 신경관 결손증 예방에 중요한 역할을 해요. 임신 전부터 하루 400~800마이크로그램을 섭취하는 것이 좋으며, 시금치, 브로콜리, 아스파라거스 같은 채소나 강화 시리얼, 보충제에서 섭취할 수 있어요.\n\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '🥛 철분과 칼슘 섭취',
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
                            ': 철분은 빈혈 예방에, 칼슘은 태아의 뼈 형성에 중요해요. 적색 육류, 콩류, 시금치로 철분을, 우유, 치즈, 요거트, 브로콜리로 칼슘을 충분히 섭취해 주세요.\n\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '🥜 단백질과 건강한 지방 섭취',
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
                            ': 단백질은 태아의 성장에 필수적이고, 오메가-3 지방산은 뇌 발달에 좋아요. 닭고기, 생선, 계란, 콩류로 단백질을, 연어, 아보카도, 견과류로 건강한 지방을 챙기세요.\n\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '💧 수분 섭취:',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: ' 하루 8잔 이상의 물을 마셔 체내 수분을 유지하고, 임신 중 탈수를 방지하세요.',
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
              const SizedBox(height: 31),
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
              SizedBox(height: 24),
              Text(
                '4. 피해야 할 음식 ',
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
                height: 300,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '❗임신을 준비할 때는 피해야 할 음식도 있어요. 다음과 같은 음식들은 임신에 악영향을 줄 수 있으니 주의해 주세요.\n\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '🥩 ',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text:
                            '가공육과 날음식: 덜 익은 고기나 생선, 날달걀 등은 세균에 오염될 위험이 있어 피하는 것이 좋습니다. 임신을 계획 중이라면 이들 음식의 섭취를 제한하는 것이 안전해요.\n\n☕ 카페인: 과도한 카페인 섭취는 태아의 성장에 영향을 줄 수 있어요. 하루에 한두 잔의 커피는 괜찮지만, 카페인 섭취량을 줄이는 것이 좋습니다.\n\n🍻 알코올과 흡연: 알코올과 흡연은 임신에 부정적인 영향을 미칠 수 있어요. 임신 전부터 알코올과 담배를 피하는 것이 가장 좋습니다.',
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
              SizedBox(
                height: 42,
              ),
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
