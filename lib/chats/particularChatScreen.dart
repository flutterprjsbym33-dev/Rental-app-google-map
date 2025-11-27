import 'package:flutter/cupertino.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_zim/zego_zim.dart';


class ChatPage extends StatelessWidget {
  final String targetUserId;

  const ChatPage({super.key, required this.targetUserId});

  @override
  Widget build(BuildContext context) {
    return ZIMKitMessageListPage(
      conversationID: targetUserId,
      conversationType: ZIMConversationType.peer, // 1-to-1 chat
    );
  }
}
