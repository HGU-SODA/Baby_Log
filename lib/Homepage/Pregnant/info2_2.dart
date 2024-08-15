import 'package:flutter/material.dart';

class Info2_2 extends StatelessWidget {
  const Info2_2({super.key});

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
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '3. 임신 중 여드름',
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
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '🧘🏻 발생 원인: 임신 초기에는 호르몬의 변화로 인해 피지 분비가 증가하면서 여드름이 생기기도 해요.‍\n\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '관리방법:\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '💭 ',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '클렌징',
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
                            ': 피부를 깨끗하게 유지하는 것이 중요해요. 순한 성분의 클렌저를 사용하여 아침저녁으로 세안을 해주세요.\n💭 ',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '피부 진정',
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
                            ': 알로에 베라나 녹차 추출물 같은 피부 진정 성분이 포함된 제품을 사용하는 것도 좋아요.',
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
              SizedBox(height: 37),
              Text(
                '임산부를 위한 피부 관리 팁',
                style: TextStyle(
                  color: Color(0xFFFF9C27),
                  fontSize: 20,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(height: 24),
              Image.asset(
                'assets/Pinfo2_3.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 60),
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
