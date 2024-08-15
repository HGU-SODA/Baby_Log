import 'package:baaby_log/Community/LikeButton.dart';
import 'package:baaby_log/Community/PostDetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_symbols_icons/symbols.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  List<String> collections = ['posts'];

  void _performSearch() async {
    String query = _searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    List<Map<String, dynamic>> allResults = [];

    // Title에 대해 검색
    QuerySnapshot titleSnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    for (var doc in titleSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      allResults.add({
        'data': data,
        'collectionName': 'posts',
        'id': doc.id,
        'type': data['type'] ?? 'default',
        'authorId': data['authorId'] ?? '',
      });
    }

    setState(() {
      searchResults = allResults;
    });
  }

  Stream<String> getUserIcon(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => snapshot.data()?['status'] ?? '');
  }

  String _getIconAsset(String icon) {
    switch (icon) {
      case '둘러볼게요':
        return 'assets/sun.png';
      case '임신 중이에요':
        return 'assets/leaf.png';
      case '아기를 키우고 있어요':
        return 'assets/sprout.png';
      default:
        return 'assets/default_icon.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasCardItems = searchResults.any((result) => result['type'] == '자랑로그');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: 360,
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Color(0XFFFF9C27),
                    decoration: InputDecoration(
                      hintText: '검색어를 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: _performSearch,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: searchResults.isEmpty
                ? Center(child: Text('검색 결과가 없습니다.'))
                : hasCardItems
                    ? GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          var data = searchResults[index]['data']
                              as Map<String, dynamic>?;
                          String docId = searchResults[index]['id'];
                          String type =
                              searchResults[index]['type'] ?? 'default';
                          final userId = searchResults[index]['authorId'];

                          if (type == '자랑로그') {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostDetail(postId: docId, type: type),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 0.8,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: data?['imageUrl'] != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(12)),
                                              child: Image.network(
                                                data!['imageUrl'],
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              color: Colors.grey[300],
                                              child:
                                                  Center(child: Text('이미지 없음')),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              StreamBuilder<String>(
                                                stream: getUserIcon(userId),
                                                builder: (context, snapshot) {
                                                  final userIcon =
                                                      snapshot.data ?? '';
                                                  return Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFFFBA69),
                                                      shape: const OvalBorder(),
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                        _getIconAsset(userIcon),
                                                        width: 12,
                                                        height: 12,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                data?['authorNickname'] ??
                                                    '닉네임 없음',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Spacer(),
                                              LikeButton(
                                                  postId: docId,
                                                  log4: false,
                                                  showCount: false),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            data?['title'] ?? '내용 없음',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[700]),
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '좋아요 ',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0XFF74828D),
                                                    ),
                                                  ),
                                                  StreamBuilder<int>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('posts')
                                                        .doc(docId)
                                                        .snapshots()
                                                        .map((snapshot) =>
                                                            (snapshot
                                                                    .data()?[
                                                                        'likes']
                                                                    ?.length ??
                                                                0)),
                                                    builder:
                                                        (context, snapshot) {
                                                      final likesCount =
                                                          snapshot.data ?? 0;
                                                      return Text(
                                                        '$likesCount',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0XFF74828D),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 5),
                                              Row(
                                                children: [
                                                  Text(
                                                    '댓글 ',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0XFF74828D),
                                                    ),
                                                  ),
                                                  StreamBuilder<int>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('posts')
                                                        .doc(docId)
                                                        .collection('comments')
                                                        .snapshots()
                                                        .map((snapshot) =>
                                                            snapshot
                                                                .docs.length),
                                                    builder:
                                                        (context, snapshot) {
                                                      final commentCount =
                                                          snapshot.data ?? 0;
                                                      return Text(
                                                        '$commentCount',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0XFF74828D),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      )
                    : ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          var data = searchResults[index]['data']
                              as Map<String, dynamic>?;
                          String docId = searchResults[index]['id'];
                          String type =
                              searchResults[index]['type'] ?? 'default';
                          final userId = searchResults[index]['authorId'];

                          if (type != '자랑로그') {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostDetail(postId: docId, type: type),
                                  ),
                                );
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16.0),
                                title: Text(
                                  data?['title'] ?? '제목 없음',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data?['content'] ?? '내용 없음',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        StreamBuilder<String>(
                                          stream: getUserIcon(userId),
                                          builder: (context, snapshot) {
                                            final userIcon =
                                                snapshot.data ?? '';
                                            return Container(
                                              width: 22,
                                              height: 22,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFFFFBA69),
                                                shape: const OvalBorder(),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  _getIconAsset(userIcon),
                                                  width: 12,
                                                  height: 12,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(width: 14),
                                        StreamBuilder<int>(
                                          stream: FirebaseFirestore.instance
                                              .collection('posts')
                                              .doc(docId)
                                              .collection('comments')
                                              .snapshots()
                                              .map((snapshot) =>
                                                  snapshot.docs.length),
                                          builder: (context, snapshot) {
                                            final commentCount =
                                                snapshot.data ?? 0;
                                            return Row(
                                              children: [
                                                Icon(Symbols.message_rounded,
                                                    color: Color(0XFF4E5968)),
                                                SizedBox(width: 4),
                                                Text('$commentCount'),
                                              ],
                                            );
                                          },
                                        ),
                                        LikeButton(postId: docId, log4: false),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
