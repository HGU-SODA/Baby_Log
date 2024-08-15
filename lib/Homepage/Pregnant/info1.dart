import 'package:baaby_log/Homepage/Pregnant/info1_2.dart';
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
                '👶 더 나은 산후조리를 위한 Tip',
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
                'assets/AInfo1_1.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 124,
                child: Text(
                  '안녕하세요👋 사랑스러운 아기를 기다리는 예비 엄마들!\n임신 12주차에 오신 것을 축하드려요.\n\n이 시기에는 드디어 태아의 심장 소리를 들을 수 있는 특별한 순간이 찾아온답니다. 아기의 작은 심장이 어떻게 뛰고 있는지, 그리고 이를 어떻게 확인할 수 있는지 함께 알아볼게요.😀',
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
                '태아의 심장 소리를 듣는 시기와 방법',
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
                'assets/Pinfo1_2.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 383,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '임신 12주차는 정말 특별한 순간이에요.✋ 대부분의 임산부는 이때부터 태아의 심장 소리를 듣기 시작하는데요, 어떻게 들을 수 있는지 알아볼까요?‍\n\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
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
                        text: '병원에서의 청진',
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
                            ': 병원이나 산부인과에 가시면 의사 선생님이 도플러 초음파 기기를 사용해서 아기의 심장 소리를 들려주실 거예요. 도플러 초음파는 태아의 심장 소리를 증폭시켜 주기 때문에 더 잘 들을 수 있답니다.이때의 경험은 정말 감동적일 거예요.\n\n💭 ',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '가정용 도플러 기기',
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
                            ': 집에서도 태아의 심장 소리를 듣고 싶다면, 가정용 도플러 기기를 사용할 수 있어요. 하지만, 이 기기는 너무 자주 사용하지 않도록 주의해 주세요. 병원에서 듣는 것이 가장 정확하고 안전하니까요.',
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
