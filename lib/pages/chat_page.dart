import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 16,
              child: const Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'Nerea Alvarez Bornes',
              style: TextStyle(color: Colors.black87, fontSize: 10),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              itemBuilder: (_, i) => Text('$i'),
              physics: BouncingScrollPhysics(),
              reverse: true,
            )),
            const Divider(
              height: 1,
            ),
            _inputChat(),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String text) {
              setState(() {
                if (text.trim().length > 0) {
                  _estaEscribiendo = true;
                } else {
                  _estaEscribiendo = false;
                }
              });
            },
            decoration:
                const InputDecoration.collapsed(hintText: 'Enviar mensajes'),
            focusNode: _focusNode,
          )),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: !Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      child: const Text('Enviar'),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: _estaEscribiendo
                                ? () =>
                                    _handleSubmit(_textController.text.trim())
                                : null,
                            icon: const Icon(
                              Icons.send,
                            )),
                      ),
                    ))
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    setState(() {
      _estaEscribiendo = false;
    });
  }
}
