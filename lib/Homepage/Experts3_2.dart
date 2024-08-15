import 'package:flutter/material.dart';

class Experts3_2 extends StatelessWidget {
  const Experts3_2({super.key});

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
                '우울증 증상 자기진단',
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
                height: 333,
                child: Text(
                  '-사람들과 접촉하기 싫어함    \n갑작스런 외모에 대한 변화로 자신감이 결여됩니다. 이 때문에 대인관계가 소극적이게 됩니다.    \n    \n-음식에 대한 지나친 집착과 혐오    \n평상시 좋아하던 음식도 식욕이 떨어져 입에 갖다 대지 않다가도 어느 날 갑자기 음식에 대한 집착이 생겨 좋아하지 않던 음식도 먹는 등 과식할 때가 많아집니다.    \n    \n-불안정한 심리상태가 지속    \n막연한 불안감으로 신경질과 짜증이 자주 납니다.    \n    \n-불면증 또는 과면증    \n잠을 자주 설치거나 하루 종일 자기도 합니다.    \n    \n-죽음에 대한 잦은 생각    \n매사에 이욕이 없어지고 죽음에 대한 생각을 자주 합니다.',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w400,
                    height: 0,
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
              const Text(
                '임신부가 알아야 할 사항',
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
                'assets/experts3Page3.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 383,
                child: Text(
                  '외모에 자신감을 가질 수 있도록 미용에 신경을 씁니다.\n가벼운 체조와 산책으로 몸을 자주 움직입니다.\n남편과 자주 대화하는 시간을 갖고 접촉횟수를 늘립니다.    \n잡일을 가급적 줄이고 몰두할 수 있는 일을 찾아 자기 자신에게 투자합니다.    \n출산경험이 있는 친구나 선배와 정기적으로 대화하며 마음을 주고받습니다.',
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
