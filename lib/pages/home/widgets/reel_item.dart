import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/home/models/reel.dart';
import 'package:tdmubook/pages/home/services/firestore_methods_post.dart';
import 'package:tdmubook/pages/home/widgets/comment_reel_modal_bottom.dart';
import 'package:video_player/video_player.dart';
import 'like_animation.dart';

class ReelItem extends StatefulWidget {
  final Reel snapshot;

  const ReelItem({super.key, required this.snapshot});

  @override
  State<ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  UserController userController = Get.put(UserController());

  RxInt commentLength = 0.obs;

  late VideoPlayerController controller;
  bool play = true;
  bool isLikeAnimating = false;
  bool isFollowing = false;

  @override
  void initState() {
    getComments();
    controller = VideoPlayerController.network(widget.snapshot.reelUrl)
      ..initialize().then((value) => setState(() {
            controller.setLooping(true);
            controller.setVolume(1);
            controller.play();
            controller.addListener(() {
              if (controller.value.position >= controller.value.duration) {
                controller.pause();
              }
            });
          }));

    // TODO: implement initState
    super.initState();
  }

  void getComments() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('reels')
          .doc(widget.snapshot.reelId)
          .collection('comments')
          .get();
      commentLength.value = snapshot.docs.length;
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final model.User user = Provider.of<UserProvider>(context).getUser;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              play = !play;
              if (play) {
                controller.play();
              } else {
                controller.pause();
              }
            });
          },
          onDoubleTap: () async {
            await FirestoreMethodsPost().likeReel(widget.snapshot.reelId,
                userController.userCurrent.currentId!, widget.snapshot.likes);
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: VideoPlayer(controller),
              ),
              // Expanded(child: VideoPlayer(controller)),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 450,
          right: 15,
          child: Column(
            children: [
              IconButton(
                  onPressed: () async {
                    await FirestoreMethodsPost().likeReel(
                        widget.snapshot.reelId,
                        userController.userCurrent.currentId!,
                        widget.snapshot.likes);
                  },
                  icon: widget.snapshot.likes
                          .contains(userController.userCurrent.currentId!)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        )),
              Text(
                '${widget.snapshot.likes.length}',
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              IconButton(
                onPressed: () {
                  _showCommentsBottomSheet();
                },
                icon: const Icon(
                  Icons.comment_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Obx(
                () => Text(
                  commentLength.value.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Icon(
                Icons.send_outlined,
                color: Colors.white,
                size: 28,
              ),
              const Text(
                '0',
                style: TextStyle(fontSize: 12, color: Colors.white),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.pause();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) =>
                      //       ProfileScreen(uid: widget.snapshot['uid']),
                      // ));
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(widget.snapshot.profImage),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // controller.pause();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) =>
                      //       ProfileScreen(uid: widget.snapshot['uid']),
                      // ));
                    },
                    child: Text(
                      widget.snapshot.username,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.snapshot.description,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
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
              child: CommentReelModalBottom(
                  snap: widget.snapshot,
                  onSend: () {
                    getComments();
                  }), // Nội dung modal
            );
          },
        );
      },
    );
  }
}
