import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addPost(String title, String content, String type) async {
  final postsRef = FirebaseFirestore.instance.collection('posts');

  await postsRef.add({
    'title': title,
    'content': content,
    'type': type,
    'createdAt': Timestamp.now(),
    'likesCount': 0,
  }).catchError((error) {
    print("Error adding post: $error");
  });
}
