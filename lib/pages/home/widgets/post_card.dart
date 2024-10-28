import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/home/models/post.dart';
import 'package:tdmubook/pages/home/widgets/comment_modal_bottom.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/utils/date_time.dart';
import '../services/firestore_methods_post.dart';
import 'like_animation.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.snap});
  final Post snap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  UserController userController = Get.put(UserController());

  TextEditingController commentController = TextEditingController();
  bool isLikeAnimating = false;
  bool isLike = false;
  bool isCommentExpanded = false;
  RxInt commentLength = 0.obs;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap.postId)
          .collection('comments')
          .get();

      commentLength.value = snapshot.docs.length;
    } catch (e) {
      showSnackBar(context, 'Lỗi: $e');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          _buildHeaderSection(),
          _buildDescriptionSection(),
          _buildImageSection(),
          _buildCommentSection(),
          if (isCommentExpanded)
            _buildExpandedCommentSection(), // Conditionally show the expanded comment section
        ],
      ),
    );
  }

  Widget _buildButtonOptions({
    required int quantity,
    required IconData icon,
    required Function() onPressed,
    Color? color,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            quantity.toString(),
            style: styleS14W6(Colors.black),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: color ?? Colors.black, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
          .copyWith(right: 0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.snap.profImage),
              radius: 18,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      widget.snap.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          userController.typeEmail != 'admin'
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () async {
                    _showPostDialogOptions();
                  },
                  icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        widget.snap.description,
        style: styleS14W4(Colors.black),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildImageSection() {
    return GestureDetector(
      onTap: () {
        _showCommentsBottomSheet();
      },
      onDoubleTap: () {
        setState(() {
          isLikeAnimating = true;
          isLike = true;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap.postUrl,
              fit: BoxFit.contain,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isLikeAnimating ? 1 : 0,
            child: LikeAnimation(
              isAnimating: isLikeAnimating,
              duration: const Duration(milliseconds: 400),
              onEnd: () async {
                await FirestoreMethodsPost().likePost(widget.snap.postId,
                    userController.userCurrent.currentId!, widget.snap.likes);
                setState(() {
                  isLikeAnimating = !isLikeAnimating;
                });
              },
              child: Icon(
                Icons.thumb_up_alt_rounded,
                color: Colors.blue,
                size: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Row(
      children: [
        SizedBox(width: 16),
        _buildButtonOptions(
          quantity: widget.snap.likes.length,
          icon:
              widget.snap.likes.contains(userController.userCurrent.currentId!)
                  ? Icons.thumb_up_alt_rounded
                  : Icons.thumb_up_alt_outlined,
          color:
              widget.snap.likes.contains(userController.userCurrent.currentId!)
                  ? Colors.blue
                  : Colors.black,
          onPressed: () async {
            await FirestoreMethodsPost().likePost(widget.snap.postId,
                userController.userCurrent.currentId!, widget.snap.likes);
            setState(() {
              isLike = !isLike;
            });
          },
        ),
        SizedBox(width: 16),
        Obx(
          () {
            return _buildButtonOptions(
              quantity: commentLength.value,
              icon: Icons.comment_outlined,
              onPressed: () {
                setState(() {
                  isCommentExpanded = !isCommentExpanded; // Toggle expansion
                });
              },
            );
          },
        ),
        SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            formatDateTimePost(widget.snap.dataPublished.toDate()),
            style: styleS14W4(Color(0xff00B389)),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedCommentSection() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      height: isCommentExpanded ? 80 : 0, // Adjust height as needed
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.snap.profImage),
                    radius: 16,
                  )),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        _sentComment();
                      },
                      icon: const Icon(Icons.send, color: Colors.blue),
                    ),
                    hintText: 'Viết bình luận...',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCommentsBottomSheet() {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 0.9,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0), // Bắt đầu từ dưới cùng màn hình
                end: Offset.zero, // Kết thúc ở vị trí hiện tại
              ).animate(CurvedAnimation(
                parent: ModalRoute.of(context)!
                    .animation!, // Sử dụng animation mặc định của modal
                curve: Curves.easeInOut, // Hiệu ứng trượt mượt mà
              )),
              child: CommentModalBottom(
                  snap: widget.snap,
                  onSend: () {
                    getComments();
                  }), // Nội dung modal
            );
          },
        );
      },
    );
  }

  void _sentComment() async {
    bool success = await FirestoreMethodsPost().postComment(
        widget.snap.postId,
        commentController.text,
        userController.userCurrent.currentId!,
        userController.userCurrent.name!,
        userController.userCurrent.photoUrl!);

    if (success) {
      showSnackBar(context, 'Đã gửi bình luận');
      getComments();
    }
    setState(() {
      commentController.text = '';
    });
  }

  void _showPostDialogOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Align(alignment: Alignment.center, child: const Text('Bài viết')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              ListTile(
                title: const Text('Chỉnh sửa bài viết'),
                onTap: () async {},
              ),
              Divider(),
              ListTile(
                title: const Text('Xóa bài viết'),
                onTap: () async {
                  bool success = await FirestoreMethodsPost()
                      .deletePost(widget.snap.postId);
                  if (success) {
                    showSnackBar(context, 'Đã xóa bài viết');
                    Navigator.pop(context);
                  } else {
                    showSnackBar(context, 'Lỗi: Không thể xóa bài viết');
                  }
                },
              ),
              Divider(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
          ],
        );
      },
    );
  }
}
