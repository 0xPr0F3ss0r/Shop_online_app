import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_app/controller/homecontroller.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// ignore: must_be_immutable
class Livestreampage extends StatelessWidget {
  HomeController homecontroller = Get.put(HomeController());
  final String liveID;
  final bool isHost;
  final String userID;
  final String userName;

   Livestreampage({
    required this.liveID,
    required this.isHost,
    required this.userID,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 1873545362, 
        userID: userID,
        userName: userName,
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host() 
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
        appSign: "95a73b7536207f53887e63fbb5bafb8a2f4f2efee1539cddb1061376aa6a808d", 
        events: ZegoUIKitPrebuiltLiveStreamingEvents(
          onStateUpdated: (ZegoLiveStreamingState state) {
      if (state == ZegoLiveStreamingState.living) {
        homecontroller.updateUserLiveStatus(homecontroller.uid ?? '1111',homecontroller.Liveid.value,true,true);
      } else if (state == ZegoLiveStreamingState.ended) {
        homecontroller.stopLiveStream();
        homecontroller.updateUserLiveStatus(homecontroller.uid ?? '1111',homecontroller.Liveid.value,false,false);
      }
    },
    onLeaveConfirmation: (
  ZegoLiveStreamingLeaveConfirmationEvent event,
  Future<bool> Function() defaultAction,
) async {
  bool shouldLeave = await showDialog(
        context: event.context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to end the live stream?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('End Stream'),
            ),
          ],
        ),
      ) ?? false; 

  if (shouldLeave) {
    homecontroller.stopLiveStream();
    return true; 
  } else {
    return false;
  }
},
  ),
      ),
    );
  }
}

