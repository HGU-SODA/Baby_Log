import 'package:baaby_log/Mypage/ChangeBabyInfo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeIconPage extends StatefulWidget {
  const ChangeIconPage({super.key});

  @override
  _ChangeIconPageState createState() => _ChangeIconPageState();
}

class _ChangeIconPageState extends State<ChangeIconPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedIcon = '';

  @override
  void initState() {
    super.initState();
    _loadCurrentIcon();
  }

  Future<void> _loadCurrentIcon() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _selectedIcon = userData['status'] ?? '';
      });
    }
  }

  Future<void> _updateIcon() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user.uid).get();

      // Check if the user's nickname is "몽글이"
      String nickname = userData['nickname'] ?? '';

      if (_selectedIcon == '임신 중이에요' && nickname == '몽글이') {
        // Redirect to ChangeNicknamePage if nickname is "몽글이" and status is "임신 중이에요"
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChangeBabyInfoPage(),
          ),
        );
      } else {
        // Proceed with the original update if nickname is not "몽글이"
        await _firestore.collection('users').doc(user.uid).update({
          'status': _selectedIcon,
        });
        Navigator.pop(context, true); // Return to the previous screen
      }
    }
  }

  Widget _buildIcon(String label, String imageAsset) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIcon = label;
          });
        },
        child: Row(
          children: [
            Container(
              width: 37,
              height: 37,
              decoration: ShapeDecoration(
                color: _selectedIcon == label
                    ? const Color(0xFFFF9C27)
                    : const Color(0xFFFFDFBB),
                shape: const OvalBorder(),
              ),
              child: Center(
                child: Image.asset(
                  imageAsset,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            '내 계정',
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 20,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _updateIcon,
            child: const Text(
              '완료',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(23.0, 20.0, 0, 0),
            child: Text(
              '아이콘 변경',
              style: TextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 18,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          _buildIcon('둘러볼게요', 'assets/sun.png'),
          _buildIcon('임신 중이에요', 'assets/leaf.png'),
          _buildIcon('아기를 키우고 있어요', 'assets/sprout.png'),
        ],
      ),
    );
  }
}
