import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tdmubook/pages/auth/controller/user_controller.dart';
import 'package:tdmubook/pages/auth/models/user_current.dart';
import 'package:tdmubook/shared/constants/live_stream.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import '../../../shared/constants/video_call.dart';
import '../widgets/common.dart';

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;
  final UserCurrent userCurrent;

  const LivePage({
    super.key,
    required this.liveID,
    this.isHost = false, required this.userCurrent,
  });

  @override
  State<StatefulWidget> createState() => LivePageState();
}

class LivePageState extends State<LivePage> {
  UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('room_live').doc(widget.liveID).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            // Phòng không còn tồn tại
            Navigator.pop(context);
            return Container();
          }

          return Scaffold(
            // appBar: userController.typeEmail == 'admin'
            //     ? AppBar(
            //   title: Text(widget.userCurrent.name ?? 'user_local'),
            //   actions: [
            //     IconButton(
            //       icon: Icon(Icons.exit_to_app),
            //       onPressed: () => stopLive(widget.liveID),
            //     ),
            //   ],
            // )
            //     : null,

            body: ZegoUIKitPrebuiltLiveStreaming(
              appID: appId, // Thay thế với AppID thực tế
              appSign: appSign, // Thay thế với AppSign thực tế
              userID: widget.userCurrent.currentId ?? localUserID, // Thay thế với ID thực tế
              userName: widget.userCurrent.name ?? 'user_local', // Thay thế với tên thực tế
              liveID: widget.liveID,
              events: userController.typeEmail == 'admin'
                  ? ZegoUIKitPrebuiltLiveStreamingEvents(
                onStateUpdated: (state) {
                  if (state == ZegoLiveStreamingState.ended) {
                    stopLive(widget.liveID);
                    Navigator.pop(context);
                  }
                },
              ) : null,
              config: (widget.isHost
                  ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
                  : ZegoUIKitPrebuiltLiveStreamingConfig.audience())
                ..avatarBuilder = customAvatarBuilder
                ..bottomMenuBar = ZegoLiveStreamingBottomMenuBarConfig(
                  showInRoomMessageButton: true,
                )

            ),
          );
        },
      ),
    );
  }

  void stopLive(String liveID) async {
    // Xóa phòng livestream khỏi Firestore
    await FirebaseFirestore.instance.collection('room_live').doc(liveID).delete();
  }
}