import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;
  const ChatMessage(
      {super.key,
      required this.texto,
      required this.uid,
      required this.animationController});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: widget.animationController,
        child: SizeTransition(
          sizeFactor: CurvedAnimation(
              parent: widget.animationController, curve: Curves.easeOut),
          child: Container(
              child: widget.uid == '123' ? _myMessage() : _notMessage()),
        ));
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 10),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Color(0xff4D9EF6),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(widget.texto),
      ),
    );
  }

  Widget _notMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 50),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Color(0xffE4E5E8),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(widget.texto),
      ),
    );
  }
}
