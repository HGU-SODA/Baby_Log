import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/cupertino.dart';

class ChangeBabyInfoPage extends StatefulWidget {
  const ChangeBabyInfoPage({Key? key}) : super(key: key);

  @override
  _ChangeBabyInfoPageState createState() => _ChangeBabyInfoPageState();
}

class _ChangeBabyInfoPageState extends State<ChangeBabyInfoPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadBabyInfo();
    initializeDateFormatting('ko_KR', null).then((_) {
      setState(() {});
    });
  }

  Future<void> _loadBabyInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _nicknameController.text = userData['nickname'] ?? ''; // 아이의 태명 불러오기
        _selectedDate =
            DateTime.parse(userData['dueDate'] ?? DateTime.now().toString());
      });
    }
  }

  Future<void> _saveBabyInfo() async {
    if (_nicknameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('태명을 입력해주세요.'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'nickname': _nicknameController.text.trim(),
          'dueDate': _selectedDate.toString(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('정보가 저장되었습니다.'),
            duration: Duration(milliseconds: 500),
          ),
        );

        // 변경된 태명을 Navigator.pop을 통해 전달
        Navigator.pop(context, _nicknameController.text.trim());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('사용자 정보가 없습니다. 다시 시도해주세요.'),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('정보 저장 실패: ${e.toString()}'),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _selectedDate,
              minimumYear: 1900,
              maximumYear: 2101,
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  _selectedDate = newDateTime;
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '아이 정보 변경',
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
            onPressed: _saveBabyInfo,
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
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(23.0, 26, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '태명 변경',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 18,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField('태명', _nicknameController, false, hintText: '몽글이'),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(23.0, 0, 23.0, 0),
            child: GestureDetector(
              onTap: _showDatePicker,
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: DateFormat('yyyy.MM.dd').format(_selectedDate),
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    hintText: '출산 예정일',
                    hintStyle: const TextStyle(
                      color: Color(0xFFA7A7A7),
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFFA7A7A7),
                      ),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isPassword, {
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23.0, 0, 23.0, 0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: Color(0XFFFF9C27),
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFA7A7A7),
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black54, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black54),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
