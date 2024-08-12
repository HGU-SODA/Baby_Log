import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'WeekInfo.dart';
import 'Experts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0XFFF6F7F9),
          systemNavigationBarColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      const Text(
                        'DAY-50',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        '<12주차>',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Image.asset('assets/홈배경.png'),
                    ],
                  ),
                ],
              ),
              ScrollCards(),
              Divider(thickness: 10, height: 67, color: Color(0XFFF5F3EF)),
              Experts(),
            ],
          ),
        ),
      ),
    );
  }
}

//임신 전, 주차별, 출산 후 안내사항 카드
class ScrollCards extends StatelessWidget {
  const ScrollCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 116, 0, 30),
          child: Column(
            children: [
              Text(
                '임신 전 안내사항',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFFFFAB47),
                ),
              ),
              Text(
                '<건강한 임신을 위한 준비>',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF2D2D2D),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeekInfo(index: index + 1),
                  ),
                );
              },
              child: Container(
                width: 373,
                height: 100,
                child: Center(
                  child: Card.outlined(
                    color: Colors.white,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(13, 0, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '👶 임신 계획 세우기',
                            style: const TextStyle(
                              color: Color(0XFF2D2D2D),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            '배란 주기를 이해하며 임신 가능 시기를 파악해요.\n'
                            '이는 임신을 계획하는데 있어서 중요한 부분이에요.',
                            style: TextStyle(
                              color: Color(0XFFA8A8A8),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
