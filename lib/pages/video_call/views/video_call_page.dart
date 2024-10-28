import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../shared/constants/video_call.dart';


class VideoCallPage extends StatelessWidget {
  const VideoCallPage({Key? key, required this.callID, required this.userId, required this.userName}) : super(key: key);
  final String userId;
  final String userName;
  final String callID;


  @override
  Widget build(BuildContext context) {
    print('userId: $userId, userName: $userName, callID: $callID');
    return ZegoUIKitPrebuiltCall(
      appID: appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userId,
      userName: userName,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
