import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/student.dart';
import 'package:tdmubook/pages/home/models/post.dart';
import 'package:tdmubook/pages/home/widgets/avatar_button.dart';
import 'package:tdmubook/pages/home/widgets/post_card.dart';
import 'package:tdmubook/shared/constants/styles.dart';
import '../../../shared/utils/rive_utils.dart';
import '../../layout/widgets/custom_app_bar.dart';

class FeedAdminPage extends StatefulWidget {
  const FeedAdminPage({super.key});

  @override
  _FeedAdminPageState createState() => _FeedAdminPageState();
}

class _FeedAdminPageState extends State<FeedAdminPage> {
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
      // resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: 'Tin tức mới nhất', marginLeft: 24),
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
