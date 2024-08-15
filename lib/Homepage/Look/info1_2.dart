import 'package:flutter/material.dart';

class Info1_2 extends StatelessWidget {
  const Info1_2({super.key});

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
                '2. 배란이란?',
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
                'assets/info1_3.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 383,
                height: 143,
                child: Text(
                  '배란은 난소에서 성숙한 난자가 방출되는 과정을 말해요. 보통 생리 주기의 중간, 즉 다음 생리 시작일로부터 약 14일 전쯤에 배란이 일어나요.\n\n🩸 예를 들어, 생리 주기가 28일인 여성의 경우, 대략 생리 시작 후 14일째에 배란이 발생하게 되죠. 하지만 주기가 더 짧거나 길다면, 배란일도 그에 따라 변동될 수 있어요.\n',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 41),
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
                '3. 배란 징후 알아보기 ',
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
                height: 361,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '배란일을 추적하는 데 도움이 되는 몇 가지 신체적 징후가 있어요. 이를 통해 자연스럽게 임신 가능 시기를 예측할 수 있답니다.\n\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '💭',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: ' 기초 체온 변화',
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
                            ': 배란이 가까워지면 기초 체온이 약간 낮아졌다가, 배란 후 다시 약간 상승해요. 배란일 이후의 체온 상승은 프로게스테론 호르몬에 의한 것으로, 난자가 방출된 후 일어나는 변화랍니다. 매일 아침 기상 직후 체온을 측정해 기록해 두면 배란일을 파악하는 데 도움이 돼요.\n💭 ',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '자궁경부 점액 변화',
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
                            ': 배란기에 접어들면 자궁경부 점액의 양이 늘어나고, 질감이 투명하고 미끈하게 변해요. 이는 정자가 더 쉽게 이동할 수 있도록 도와주는 역할을 해요. 배란일이 가까워질수록 이 점액이 더 끈적해지고 투명하게 변하므로, 이를 관찰하는 것도 배란일을 예측하는 데 유용해요.\n💭',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: ' 복통(배란통)',
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
                            ': 일부 여성은 배란 시기에 복부 한쪽에 약간의 통증이나 불편함을 느낄 수 있어요. 이를 배란통이라고 하는데, 이 역시 배란 시기를 알려주는 신호 중 하나랍니다.',
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
