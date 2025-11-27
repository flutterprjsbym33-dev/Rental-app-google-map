import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatSection();
  }

}

class _ChatSection extends State<ChatSection>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Chat Section"),),
    );
  }


}