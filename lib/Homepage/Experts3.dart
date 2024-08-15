import 'package:flutter/material.dart';
import 'package:baaby_log/Homepage/Experts3_2.dart';

class Experts3 extends StatelessWidget {
  const Experts3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
                '정신건강의학과의사 / 오은영 박사',
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
                'assets/experts3Page.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 276,
                child: Text(
                  '임신부는 처음 임신 사실을 확인하면 내 아기를 갖는다는 설렘과 기쁨에 들떠있지만 임신으로 인한 몸의 변화, 출산에 대한 두려움 등으로 급격한 감정의 기복을 경험하고 우울증에 빠져듭니다.    \n    \n태아를 내세워 자기중심적이 되고 특별한 대우를 받고 싶어 하지만 심리적으로 만족감이 채워지지 않으면 신경질과 짜증이 함께 찾아오는 등 지나치게 예민한 상태에 빠지기도 합니다. 몸의 변화와 이상 징후에 적극 대처하는 것 이상으로 임신 중 찾아오는 우울증도 철저히 대비해야 합니다.    \n    \n눈에 보이지 않는 마음의 병이라고 해서 자칫 관리를 소홀히 해 우울증이 깊어지면 약물요법과 전기충격요법을 써야 할 만큼 심각한 상태로 발전할 수 있기 때문입니다.',
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
                '임신 우울증 원인',
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
                'assets/experts3Page2.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 383,
                height: 552,
                child: Text(
                  '-몸의 변화    \n여성들은 갑작스런 신체적인 변화에 가장 많이 민감해 지고 우울해 집니다.    \n    \n-호르몬의 변화    \n임신으로 호르몬의 양이 증가하면서 감정의 기복이 심해져 우울한 기분을 자주 느끼게 됩니다.    \n    \n평소 예민하고 신경질적인 사람뿐만 아니라 밝고 낙천적이었던 사람들도 감정을 억제할 수 없는 우울증에 시달립니다.    \n    \n-가족들의 무관심에서 비롯된 외로움    \n처음 임신사실을 알았을 때 축하해 주던 남편의 관심이 점점 시들해지기 시작하면 혼자 외딴섬에 내버려진 것 같은 외로움에 점점 기분이 가라앉을 수 있습니다.    \n    \n-출산의 고통에 대한 두려움    \n임신 말기가 다가오면 언제 아기가 나올지 모른다는 불안감, 분만의 고통에 대한 두려움이 지나치면 우울증으로 발전할 수 있습니다.    \n    \n특히 산후조리에 대한 철저한 대비책이 없는 사람일수록 불안감과 우울증이 심해집니다.    \n    \n-원하던 임신이 아니었을 경우    \n피임의 실패, 결혼생활의 부적응, 남편의 실직 등으로 원하던 임신이 아니었을 때 자신에 대한 자책과 우울증이 생길 수 있습니다.',
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
                          builder: (context) => const Experts3_2()),
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
