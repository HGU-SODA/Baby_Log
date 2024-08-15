import 'package:baaby_log/Homepage/Look/info2_2.dart';
import 'package:flutter/material.dart';

class Info2 extends StatelessWidget {
  const Info2({super.key});

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
                '🤰 임신 가능 시기 파악하기',
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
                'assets/info2_1.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 76,
                child: Text(
                  '임신을 계획 중이라면 임신 가능 시기를 파악하는 것이 아주 중요해요. 이 부분에 대해 자세히 알아두시면 임신 확률을 높이는 데 큰 도움이 될 거예요. 지금부터 임신 가능 시기를 어떻게 파악할 수 있는지 세부적으로 설명드릴게요.',
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
                '1. 임신 가능 기간이란?',
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
                'assets/info2_2.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 248,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '임신 가능 기간',
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
                            '은 배란일을 중심으로 전후 약 5~6일 정도를 의미해요. 이 기간 동안 정자가 난자를 만나 수정될 가능성이 가장 높답니다.\n\n🔸 정자의 생존 기간: 정자는 여성의 몸에서 최대 5일 동안 생존할 수 있어요. 따라서 배란일 이전에 성관계를 가졌다면, 정자가 배란일에 난자를 만나 수정될 가능성이 있어요.\n\n🔸 난자의 생존 기간: 배란 후 난자는 약 24시간 동안 수정될 수 있는 상태를 유지해요. 이 시기가 지나면 난자는 퇴화하여 임신이 불가능해지죠. 그래서 배란 전후로 5~6일이 가장 임신 가능성이 높은 시기랍니다.',
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
                      MaterialPageRoute(builder: (context) => const Info2_2()),
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
