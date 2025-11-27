
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goolemapuse/chats/particularChatScreen.dart';
import 'package:zego_zpns/zego_zpns.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:flutter/cupertino.dart';

import '../CubitsBloc/DocumentFetchBloc.dart';

class AllChatsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AllChatsPage();
  }

}


class _AllChatsPage extends State<AllChatsPage> {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Messages")),
      body: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatPage(
                targetUserId: conversation.id,
              ),
            ),
          );
        },
      ),
    );
  }
}
