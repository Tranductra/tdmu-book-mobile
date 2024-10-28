import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:tdmubook/pages/chat/views/list_chat_user.dart';
import 'package:tdmubook/pages/home/models/post.dart';
import 'package:tdmubook/pages/home/widgets/avatar_button.dart';
import 'package:tdmubook/pages/home/widgets/post_card.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import '../../../shared/utils/rive_utils.dart';
import '../../layout/widgets/custom_app_bar.dart';

class FeedTeacherPage extends StatefulWidget {
  const FeedTeacherPage({super.key});

  @override
  _FeedTeacherPageState createState() => _FeedTeacherPageState();
}

class _FeedTeacherPageState extends State<FeedTeacherPage> {
  final ScrollController _scrollController = ScrollController();
  final UserController _userController = Get.find<UserController>();

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
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: 'Tin tức mới nhất', child:  Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListChatUser()));
                });
              },
              child: Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
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
            // AvatarButton(), // AvatarButton đã được định nghĩa
          ])
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

                    Post post = Post.fromSnap(postDocs[index]);
                    return PostCard(
                      snap: post,
                    );
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
