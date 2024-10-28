import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:tdmubook/pages/home/widgets/avatar_button.dart';
import 'package:tdmubook/pages/home/widgets/post_card.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import '../../../shared/utils/rive_utils.dart';
import '../models/post.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();
  final UserController _userController = Get.find<UserController>();
  late Student _student;

  bool _isLoading = false;
  int _visibleItemsCount = 4;
  late rive.SMIBool? isChatActive;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    _student = _userController.student;
  }

  Future<void> _loadMore() async {
    // Nếu đang tải hoặc đã tải hết dữ liệu thì dừng
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _visibleItemsCount += 4;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 48),
          child: Text('Tin tức mới nhất', style: styleS20W6(Color(0xff414141))),
        ),
        actions: [
          Row(children: [
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                height: 38,
                width: 38,
                child: rive.RiveAnimation.asset('assets/RiveAssets/icons.riv',
                    artboard: "CHAT", onInit: (artboard) {
                  rive.StateMachineController controller =
                      RiveUtils.getRiveController(artboard,
                          stateMachineName: "CHAT_Interactivity");
                  isChatActive = controller.findSMI("active") as rive.SMIBool;
                  isChatActive!.change(true);
                }),
              ),
            ),
            SizedBox(width: 4),
            AvatarButton(), // AvatarButton đã được định nghĩa
          ])
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('dataPublished', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var postDocs = snapshot.data!.docs;
          print(postDocs.toString());
          if (postDocs.isEmpty) {
            return const Center(child: Text('Chưa có bài viết nào.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: (_visibleItemsCount < postDocs.length
                          ? _visibleItemsCount
                          : postDocs.length) +
                      (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _visibleItemsCount && _isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (index >= postDocs.length) {
                      return const SizedBox.shrink();
                    }

                    // var postData =
                    //     postDocs[index].data() as Map<String, dynamic>? ?? {};
                    //
                    // Post post = Post.fromJson(postData);
                    // return PostCard(
                    //   snap: post,
                    // );
                  },
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: CircularProgressIndicator(),
                )
            ],
          );
        },
      ),
    );
  }
}
