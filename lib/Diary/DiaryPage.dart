import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'UploadImage.dart';
import 'firestore_service.dart';

class DiaryPage extends StatefulWidget {
  final DateTime date;
  final String? initialNote;
  final String? initialImageUrl;
  final void Function(String? imageUrl, String note) onSave;
  final VoidCallback onDelete;

  DiaryPage({
    required this.date,
    this.initialNote,
    this.initialImageUrl,
    required this.onSave,
    required this.onDelete,
  });

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late TextEditingController _noteController;
  final FirestoreService _firestoreService = FirestoreService();
  bool _isSaved = false;
  bool _isEditing = false;
  Uint8List? _imageBytes;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
    _imageUrl = widget.initialImageUrl;
    _loadDiaryEntry();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadDiaryEntry() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 상태가 아닙니다.')),
      );
      return;
    }
    try {
      final diaryEntry =
          await _firestoreService.getDiaryEntry(user.uid, widget.date);
      if (diaryEntry != null) {
        setState(() {
          _noteController.text = diaryEntry.note ?? '';
          _imageUrl = diaryEntry.imageUrl;
          _isSaved = true; // 일기 데이터를 불러온 경우 저장 상태로 설정
        });
      } else {
        print('No diary entry found for this date.');
        _isSaved = false; // 일기가 없는 경우 저장 상태가 아님
      }
    } catch (e) {
      print('Failed to load diary entry: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다이어리를 불러오는 데 실패했습니다.')),
      );
    }
  }

  void _handleImagePick(Uint8List? imageBytes) {
    setState(() {
      _imageBytes = imageBytes;
    });
  }

  Future<void> _save() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 상태가 아닙니다.')),
      );
      return;
    }

    String? imageUrl;
    if (_imageBytes != null) {
      final fileName =
          '${widget.date.toIso8601String()}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      try {
        final storageRef =
            FirebaseStorage.instance.ref().child('images').child(fileName);
        final uploadTask = storageRef.putData(_imageBytes!);
        final snapshot = await uploadTask.whenComplete(() {});
        imageUrl = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print('Failed to upload image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지 업로드 실패')),
        );
        return;
      }
    }

    try {
      await _firestoreService.saveDiaryEntry(
        user.uid,
        widget.date,
        _noteController.text,
        imageUrl ?? _imageUrl,
      );
      _showCustomSnackbar();
      widget.onSave(imageUrl ?? _imageUrl, _noteController.text);
      setState(() {
        _isSaved = true;
        _isEditing = false;
        _imageUrl = imageUrl ?? _imageUrl;
      });
    } catch (e) {
      print('Failed to save diary entry: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다이어리 저장 실패')),
      );
    }
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
      _isSaved = false; // 수정 모드로 바뀌면 저장 상태가 아님
    });
  }

  void _showBottomSheet() {
    if (!_isSaved) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0XFFFFF4E7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildBottomSheetTile(
                icon: Icons.edit,
                text: '수정',
                onTap: () {
                  Navigator.pop(context);
                  _startEditing();
                },
              ),
              Divider(color: Color(0XFFEEE5DA)),
              _buildBottomSheetTile(
                icon: Icons.delete,
                text: '삭제',
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteDialog();
                },
              ),
              Divider(color: Color(0XFFEEE5DA)),
              _buildBottomSheetTile(
                text: '취소',
                onTap: () {
                  Navigator.pop(context);
                },
                isCancel: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Container _buildBottomSheetTile({
    IconData? icon,
    required String text,
    required VoidCallback onTap,
    bool isCancel = false,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isCancel ? Colors.transparent : Color(0XFFFFF4E7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: <Widget>[
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(icon),
                ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0XFFFFEDD8),
          title: Text('삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteDiaryEntry();
              },
              child: Text(
                '예',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '아니오',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteDiaryEntry() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 상태가 아닙니다.')),
      );
      return;
    }

    try {
      // Firestore 문서 삭제
      await _firestoreService.deleteDiaryEntry(user.uid, widget.date);

      // Firebase Storage에서 이미지 삭제
      if (_imageUrl != null) {
        final storageRef = FirebaseStorage.instance.refFromURL(_imageUrl!);
        await storageRef.delete();
      }

      // 앱 상태 업데이트
      widget.onDelete();
      _resetState(); // 상태 초기화
      Navigator.pop(context);
    } catch (e) {
      print('Failed to delete diary entry: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('삭제 실패')),
      );
    }
  }

  void _resetState() {
    setState(() {
      _isSaved = false;
      _isEditing = true; // 삭제 후 수정 모드로 전환
      _noteController.text = '';
      _imageBytes = null;
      _imageUrl = null;
    });
  }

  void _showCustomSnackbar() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final snackbar = SnackBar(
      content: Container(
        width: double.infinity,
        color: Color(0XFFFFDCB2),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            '저장되었습니다!',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0XFFFFDCB2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      duration: Duration(seconds: 1),
    );
    scaffoldMessenger.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.xmark),
        ),
        centerTitle: true,
        title: Text(
          DateFormat('yyyy년 M월').format(widget.date),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          if (_isEditing || !_isSaved) // 수정 모드이거나 저장되지 않은 경우 체크마크 표시
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _save,
            ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      '${DateFormat('d ').format(widget.date)}',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${DateFormat('EEEE').format(widget.date)}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    if (_isSaved &&
                        !_isEditing) // 저장된 상태이면서 수정 모드가 아닐 때 ellipses 버튼 표시
                      IconButton(
                        onPressed: _showBottomSheet,
                        icon: Icon(Icons.more_vert),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _noteController,
                      cursorColor: Color(0XFFFF9C27),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '소중한 추억을 기록하세요...',
                        hintStyle: TextStyle(color: Color(0XFF74828D)),
                      ),
                      style: TextStyle(color: Color(0XFF4E5968)),
                      maxLines: null,
                      enabled: _isEditing ||
                          (_noteController.text.isEmpty && _imageBytes == null),
                      // 수정 모드일 때, 글과 사진 영역이 모두 비어있을 때만 입력 가능
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.white,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (_imageBytes != null)
                            Image.memory(
                              _imageBytes!,
                              fit: BoxFit.cover,
                            )
                          else if (_imageUrl != null)
                            Image.network(
                              _imageUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                .expectedTotalBytes!)
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Center(
                                    child: Text('이미지를 불러오는 중 문제가 발생했습니다.'));
                              },
                            ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: UploadImage(onPickImage: _handleImagePick),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
