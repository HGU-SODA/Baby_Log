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
                '2. 올바른 모유 수유 자세',
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
                'assets/Ainfo2_3.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 383,
                height: 240,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '편안한 자세 찾기:',
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
                            ' 모유 수유를 할 때는 엄마와 아기 모두 편안한 자세를 유지하는 것이 중요해요. 아기가 엄마의 가슴 쪽으로 몸을 밀착시킨 상태에서, 아기의 입이 유두와 잘 맞닿도록 해주세요. 크래들(포대기), 교차 요람, 풋볼 자세 등 여러 가지 자세가 있으니, 엄마와 아기에게 가장 편안한 자세를 찾아보세요.\n\n',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 16,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '아기의 입 위치:',
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
                            ' 아기의 입이 유두를 깊이 물고 있어야 해요. 입을 크게 벌리고 유륜까지 충분히 물어야 젖을 효과적으로 빨 수 있고, 엄마의 유두도 상하지 않아요. 수유 중에 아기가 잘 빨지 못하거나 아파하면, 아기의 입 위치를 다시 조정해 보세요.',
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
              SizedBox(height: 27),
              Text(
                '3. 수유 빈도와 양 조절',
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
                'assets/Ainfo2_4.png',
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
