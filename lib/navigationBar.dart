import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Homepage/PregnantHomePage.dart';
import 'Homepage/LookHomePage.dart';
import 'Homepage/ParentHomePage.dart';
import 'Community/CommunityPage.dart';
import 'Mypage/MyPage.dart';
import 'Diary/Calendar.dart';

class navigationBar extends StatefulWidget {
  const navigationBar({Key? key}) : super(key: key);

  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {
  int _selectedIndex = 0;
  late Future<Widget> _homePage;
  bool _hasShownBottomSheet = false;

  @override
  void initState() {
    super.initState();
    _homePage = _getHomePageBasedOnStatus();
    _checkIfBottomSheetHasBeenShown();
  }

  Future<void> _checkIfBottomSheetHasBeenShown() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _hasShownBottomSheet = userData['hasShownBottomSheet'] ?? false;
      });
    }
  }

  Future<void> _setBottomSheetAsShown() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'hasShownBottomSheet': true});
    }
  }

  Future<Widget> _getHomePageBasedOnStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      String status = userData['status'] ?? '';

      switch (status) {
        case '둘러볼게요':
          return LookHomePage();
        case '임신 중이에요':
          return PregnantHomePage();
        case '아기를 키우고 있어요':
          return ParentHomePage();
        default:
          return LookHomePage(); // 기본값
      }
    }
    return LookHomePage(); // 사용자가 로그인하지 않은 경우 기본값
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      // 홈 버튼을 눌렀을 때 status를 다시 확인하고 홈페이지를 업데이트
      setState(() {
        _homePage = _getHomePageBasedOnStatus();
        _selectedIndex = index;
      });
    } else if (index == 1 && !_hasShownBottomSheet) {
      // 커뮤니티 페이지 && 바텀시트를 아직 보여주지 않았을 때
      _showRulesBottomSheet();
      _hasShownBottomSheet = true;
      setState(() {
        _selectedIndex = index;
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showRulesBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      constraints: BoxConstraints(
          maxHeight: 836, minHeight: 836, maxWidth: 430, minWidth: 430),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/사용 규칙.png'),
            SizedBox(height: 32),
            SizedBox(
              width: 175,
              height: 47,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0XFFFF9C27),
                  side: BorderSide.none,
                ),
                onPressed: () async {
                  await _setBottomSheetAsShown();
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.white, size: 24),
                    SizedBox(width: 5),
                    Text(
                      '확인했어요',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          FutureBuilder<Widget>(
            future: _homePage,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data ?? Container();
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          CommunityPage(),
          Calendar(),
          const MyPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              unselectedFontSize: 10,
              selectedFontSize: 10,
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.bold),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: '홈'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.forum_outlined), label: '커뮤니티'),
                BottomNavigationBarItem(
                    icon: Icon(Symbols.child_care), label: '기록'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined), label: '마이로그')
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: const Color(0XFFB1B8C0),
              selectedItemColor: const Color(0XFFFF9C27),
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
