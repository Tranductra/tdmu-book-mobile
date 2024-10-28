import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/reel.dart';
import '../widgets/reel_item.dart';

class ReelPage extends StatefulWidget {
  const ReelPage({super.key});

  @override
  State<ReelPage> createState() => _ReelPageState();
}

class _ReelPageState extends State<ReelPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: StreamBuilder(
          stream: _firestore
              .collection('reels')
              .orderBy('dataPublished', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return PageView.builder(
              itemBuilder: (context, index) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                Reel reel = Reel.fromDocument(snapshot.data!.docs[index]);

                return ReelItem(snapshot: reel);
              },
              controller: PageController(initialPage: 0),
              scrollDirection: Axis.vertical,
            );
          },
        ),
      ),
    );
  }
}
