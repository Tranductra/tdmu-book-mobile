import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/home/models/reel.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/utils/date_time.dart';
import '../services/firestore_methods_post.dart';
import 'comment_section.dart';

class CommentReelModalBottom extends StatefulWidget {
  final Reel snap;
  final Function onSend;

  const CommentReelModalBottom(
      {super.key, required this.snap, required this.onSend});

  @override
  State<CommentReelModalBottom> createState() => _CommentReelModalBottomState();
}

class _CommentReelModalBottomState extends State<CommentReelModalBottom> {
  final TextEditingController commentController = TextEditingController();

  UserController userController = Get.put(UserController());

  late StreamController<List<dynamic>>
      _commentsController; // Tạo StreamController

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _commentsController =
        StreamController<List<dynamic>>(); // Khởi tạo StreamController
    _fetchComments(); // Lấy bình luận ban đầu
  }

  void _fetchComments() async {
    FirebaseFirestore.instance
        .collection('reels')
        .doc(widget.snap.reelId)
        .collection('comments')
        .orderBy('datePublished', descending: true)
        .snapshots()
        .listen((snapshot) {
      // Khi có dữ liệu mới, phát dữ liệu qua StreamController
      if (!_commentsController.isClosed) {
        _commentsController
            .add(snapshot.docs.map((doc) => doc.data()).toList());
      }
    });
  }

  @override
  void dispose() {
    _commentsController.close(); // Đóng StreamController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Bình luận', style: styleS20W6(Colors.black)),
          Expanded(
            child: StreamBuilder(
              // stream: FirebaseFirestore.instance
              //     .collection('posts')
              //     .doc(widget.snap.postId)
              //     .collection('comments')
              //     .orderBy('datePublished', descending: true)
              //     .snapshots(),
              stream: _commentsController.stream, // Lắng nghe StreamController
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // final comments = snapshot.data!.docs;
                final comments = snapshot.data ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    // final comment = comments[index];
                    // return _buildCommentItem(comment.data());
                    return _buildCommentItem(comments[index]);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16),
          CommentSection(
            commentController: commentController,
            onSend: () {
              _sentComment();
            },
          )
          // Add more comments as needed
        ],
      ),
    );
  }

  Widget _buildCommentItem(dynamic snap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(snap['profilePic']),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(snap['name'], style: styleS14W6(Colors.black)),
                    SizedBox(width: 8),
                    Text(formatDateTimePost(snap['datePublished'].toDate()),
                        style: styleS14W4(Colors.grey)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(snap['text'],
                            style: styleS14W4(Colors.black))),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.thumb_up_alt_outlined,
                          size: 16, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('0 likes', style: styleS14W4(Colors.grey)),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {},
                      child:
                          Text('Trả lời', style: styleS14W4(Colors.blueAccent)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text('Xem 19 trả lời',
                          style: styleS14W4(Colors.grey)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sentComment() async {
    bool success = await FirestoreMethodsPost().reelComment(
      widget.snap.reelId,
      commentController.text,
      userController.userCurrent.currentId!,
      userController.userCurrent.name!,
      userController.userCurrent.photoUrl!,
    );

    if (success) {
      showSnackBar(context, 'Đã gửi bình luận');
      widget.onSend();
      commentController.clear(); // Dọn sạch trường nhập
    }
  }

// void _sentComment() async {
//   print(widget.snap.postId);
//   print(commentController.text);
//   print(userController.userCurrent.currentId);
//   print(userController.userCurrent.name);
//   print(userController.userCurrent.photoUrl);
//   bool success = await FirestoreMethodsPost().postComment(
//       widget.snap.postId,
//       commentController.text,
//       userController.userCurrent.currentId!,
//       userController.userCurrent.name!,
//       userController.userCurrent.photoUrl!);
//   print(success);
//
//   if (success) {
//     showSnackBar(context, 'Đã gửi bình luận');
//     commentGetXCon.commentCount.value++; // Tăng số lượng bình luận
//   }
//   commentController.text = '';
//   // setState(() {
//   //
//   // });
// }
}
