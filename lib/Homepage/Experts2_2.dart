import 'package:flutter/material.dart';

class Experts2_2 extends StatelessWidget {
  const Experts2_2({super.key});

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
                '조기진통 원인',
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
                height: 314,
                child: Text(
                  '조산을 발생시키는 요인으로 감염, 정신적 스트레스, 다태임신과 같이 자궁이 과다로 팽창된 경우, 자궁과 태반의 혈류장애, 자궁출혈 및 자궁의 구조적이상(기형)등으로 대별하여 볼 수 있습니다.\n\n이러한 요인들은 여러가지 생화학물질을 태반과 자궁내막으로부터 생성 유리시켜서 자궁수축을 일으키고 자궁경부를 개대시켜서 결국 조산을 발생시키는 것으로 알려져 있습니다.\n\n한편, 조산의 기왕력이 있거나, 임산부의 키가 작은 경우(152 Cm이하), 나이가 21세 미만이나, 36세 이상인 경우, 쌍태아임신, 자궁출혈, 흡연, 음주, 영양부족등의 경우에 조산의 위험이 증가되는 것으로 보고되어 있습니다.\n\n기왕력이란? 환자가 "과거에 어떤 질병에 걸린 적이 있었다"라고 말 할 수 있는 질병의 병력(病歷)을 말합니다.',
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
              const SizedBox(height: 7),
              Image.asset(
                'assets/expert2Page3.png',
                width: 380,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 383,
                child: Text(
                  '임상적으로 조산은 파막되어 있지 않으면서 조기진통을 가진 경우나 파막이 동반된 조기 진통을 가진 경우 그리고 임신성고혈압, 조기 태반박리, 출혈이 동반된 전치태반, 자공내 태아성장 지연아 등과 같은 임산부나 태아의 상황에 의하여 불가피하게 조산임에도 불구하고 분만을 유도하여야 하는 경우로 구분해 볼 수 있습니다.    \n    \n조산의 치료를 시작하기 전에 치료 방침을 결정하여야 합니다.    \n-임산부와 태아의 상태에 따라 조산을 가능한 오랫동안 억제할 수 있는데 까지 억제하여 임신을 끌고 갈 것인지    \n-분만 전 태아의 폐성숙을 위한 약물 투여를 위하여 48시간 정도만 조산을 억제할 것인지    \n-조산을 억제할 시도를 하지 아니하고 조산아분만을 곧바로 시도하여야 할 것인지    \n    \n일단 조산을 방지 또는 억제하려는 방침이 결정되면 환자를 안정시키고 활동의 제한을 하게 되며, 수액공급 및 자궁수축억제제를 투여하게 됩니다.    \n    \n자궁경부무력증, 자궁강내 격막(septum)같은 자궁 구조적이상이 있는 경우에는 자궁경부봉합술이나, 격막제거와 같은 수술 적 처치를 필요로 합니다.',
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
