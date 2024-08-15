import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'PostForm.dart';
import 'PostList.dart';
import 'Search.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late String _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  void _showRulesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      constraints: BoxConstraints(
        maxHeight: 836, minHeight: 836, maxWidth: 430, minWidth: 430
      ),
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
                onPressed: () { Navigator.pop(context); },
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Search())
                );
              },
            ),
          ),
          bottom: TabBar(
            labelColor: Color(0XFFFFAB47),
            unselectedLabelColor: Colors.black,
            indicatorColor: Color(0XFFFFAB47),
            tabs: [
              Tab(text: '자유로그'),
              Tab(text: '질문로그'),
              Tab(text: '꿀팁로그'),
              Tab(text: '자랑로그'),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            PostList(type: '자유로그'),
            PostList(type: '질문로그'),
            PostList(type: '꿀팁로그'),
            PostList(type: '자랑로그'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0XFFFFBC6B),
          elevation: 4,
          child: Icon(Symbols.edit, color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostForm(
                  initialType: '자유로그',
                  currentUserId: _currentUserId,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
