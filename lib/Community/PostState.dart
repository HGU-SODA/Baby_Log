// 게시글 신고, 수정, 삭제 기능
import 'package:firebase_auth/firebase_auth.dart';

// Future<void> updatePost(String postId, String newContent) async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     final postDoc = await FirebaseFirestore.instance.collection('posts').doc(postId).get();
//     final postAuthorId = postDoc.data()?['authorId'];
    
//     if (postAuthorId == user.uid) {
//       // 현재 사용자가 게시물의 작성자일 경우 수정 가능
//       await FirebaseFirestore.instance.collection('posts').doc(postId).update({
//         'content': newContent,
//       });
//     } else {
//       // 권한이 없는 경우 처리
//       print('권한이 없습니다.');
//     }
//   }
// }